import 'package:firebase/firebase.dart';
import 'package:firebase/firestore.dart';
import 'package:waiteroclient/models/order.dart';

class OrdersRepository {
  CollectionReference<dynamic> ref = firestore().collection('orders');

  Future<void> sendOrder(Order orderToSend) {
    return ref.doc(orderToSend.id).set(orderToSend.toJson());
  }
}