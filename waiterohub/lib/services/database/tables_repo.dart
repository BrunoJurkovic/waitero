import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:waitero/providers/table.dart';

class TablesRepository {
  CollectionReference ref = Firestore.instance.collection('tables');

  Future<List<RestaurantTable>> getAllTables() async {
    final QuerySnapshot query =
        await ref.orderBy('name', descending: true).getDocuments();
    final List<RestaurantTable> allTables = query.documents
        .map((DocumentSnapshot doc) => RestaurantTable.fromDocument(doc))
        .toList();
    return allTables;
  }

  Future<void> createTable(RestaurantTable table) {
    return ref.document(table.id).setData(table.toJson(), merge: true);
  }

  Future<void> updateTable(String id, RestaurantTable table) {
    return ref.document(id).updateData(table.toJson());
  }

  Future<void> deleteTable(String productID) {
    return ref.document(productID).delete();
  }
}
