import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:waitero/providers/table.dart';

class TablesRepository with ChangeNotifier {
  TablesRepository() {}

  CollectionReference ref = Firestore.instance.collection('tables');

  List<RestaurantTable> _localTables;

  Future<void> init() async {
    await getAllTables();

    notifyListeners();
  }

  Future<void> getAllTables() async {
    final QuerySnapshot query = await ref.getDocuments();
    final List<RestaurantTable> allTables = query.documents
        .map((DocumentSnapshot doc) => RestaurantTable.fromDocument(doc))
        .toList();
    _localTables = allTables;
  }

  List<RestaurantTable> get tables {
    return _localTables ?? [];
  }

  void createTable(RestaurantTable table) {
    _localTables.add(table);
    notifyListeners();
  }

  Future<void> updateTable(String id, RestaurantTable newTable) {
    final int index =
        _localTables.indexWhere((RestaurantTable table) => table.id == id);
    _localTables
      ..removeAt(index)
      ..insert(index, newTable);
    notifyListeners();
    return ref.document(id).updateData(newTable.toJson());
  }

  Future<void> sendTables() async {
    await getAllTables();
    final List<RestaurantTable> dbTables = _localTables;
    for (final RestaurantTable localTable in dbTables) {
      if (dbTables.contains(localTable)) {
        final int index = dbTables.indexOf(localTable);
        dbTables.removeAt(index);
      }
    }
    final List<RestaurantTable> newTables = dbTables;
    if (newTables.isEmpty) {
      return;
    }
    final WriteBatch batch = Firestore.instance.batch();

    for (final RestaurantTable table in newTables) {
      final DocumentReference docRef = ref.document(table.id);
      batch.setData(docRef, table.toJson());
    }
    await batch.commit();
    notifyListeners();
  }

  Future<void> deleteTable(String productID) {
    _localTables.removeWhere((RestaurantTable table) => table.id == productID);
    return ref.document(productID).delete();
  }
}
