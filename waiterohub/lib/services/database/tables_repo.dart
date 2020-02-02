import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:waitero/providers/table.dart';

class TablesRepository with ChangeNotifier {
  CollectionReference ref = Firestore.instance.collection('tables');

  final Map<String, RestaurantTable> _localTables = <String, RestaurantTable>{};

  void init() {
    _getAllTables();
  }

  Future<void> _getAllTables() async {
    final QuerySnapshot query = await ref.getDocuments();
    final List<RestaurantTable> allTables = query.documents
        .map((DocumentSnapshot doc) => RestaurantTable.fromDocument(doc))
        .toList();
    for (final RestaurantTable table in allTables) {
      _localTables[table.id] = table;
    }
    notifyListeners();
  }

  Map<String, RestaurantTable> get tables {
    return _localTables ?? <String, RestaurantTable>{};
  }

  void createLocalTable(RestaurantTable table) {
    _localTables[table.id] = table;
    notifyListeners();
  }

  void discardChanges() {
    _getAllTables();
  }

  void updateLocalTableOffset(String tableID, Offset newOffset) {
    final RestaurantTable table = _localTables[tableID];
    table.tablePosition = newOffset;
    _localTables[tableID] = table;
  }

  Future<void> updateTable(String id, RestaurantTable newTable) async {
    _localTables[id] = newTable;
    await ref.document(id).updateData(newTable.toJson());
    notifyListeners();
  }

  Future<void> sendTables() {
    final WriteBatch batch = Firestore.instance.batch();
    for (final String id in _localTables.keys) {
      final DocumentReference docRef = ref.document(id);
      batch.setData(docRef, _localTables[id].toJson());
    }
    return batch.commit();
  }

  Future<void> deleteTable(String tableID) async {
    _localTables.remove(tableID);
    await ref.document(tableID).delete();
    notifyListeners();
  }
}
