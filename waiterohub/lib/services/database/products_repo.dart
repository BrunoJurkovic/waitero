import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:waitero/services/database/init.dart';

class ProductsRepo {
  ProductsRepo() {
    firestore = DatabaseHelper.firestore;
  }

  Firestore firestore;

  void addProduct() {

  }

  

}