import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:waitero/providers/table.dart';

class TablesRepository with ChangeNotifier {
  TablesRepository() {
    _init();
  }

  CollectionReference ref = Firestore.instance.collection('tables');

  List<RestaurantTable> localTables;

  Future<void> _init() async {
    localTables = await getAllTables();
    notifyListeners();
  }

  Future<List<RestaurantTable>> getAllTables() async {
    final QuerySnapshot query = await ref.getDocuments();
    final List<RestaurantTable> allTables = query.documents
        .map((DocumentSnapshot doc) => RestaurantTable.fromDocument(doc))
        .toList();
    return allTables;
  }

  void createTable(RestaurantTable table) {
    localTables.add(table);
    notifyListeners();
  }

  Future<void> sendTableToDatabase(RestaurantTable table) {
    return ref.document(table.id).setData(table.toJson(), merge: true);
  }

  Future<void> updateTable(String id, RestaurantTable newTable) {
    final int index =
        localTables.indexWhere((RestaurantTable table) => table.id == id);
    localTables
      ..removeAt(index)
      ..insert(index, newTable);
    notifyListeners();
    return ref.document(id).updateData(newTable.toJson());
  }

  Future<void> sendTables() async {
    final List<RestaurantTable> dbTables = await getAllTables();
    for (final RestaurantTable localTable in localTables) {
      if (dbTables.contains(localTable)) {
        final int index = dbTables.indexOf(localTable);
        dbTables.removeAt(index);
      }
    }
    final List<RestaurantTable> newTables = dbTables;
    if (newTables.isNotEmpty) {
      newTables.forEach(sendTableToDatabase);
      notifyListeners();
    }
  }

  Future<void> deleteTable(String productID) {
    localTables.removeWhere((RestaurantTable table) => table.id == productID);
    return ref.document(productID).delete();
  }
}
