import 'package:firebase/firebase.dart';
import 'package:firebase/firestore.dart';
import 'package:waiteroclient/models/product.dart';

class ProductsRepository {
  CollectionReference<dynamic> ref = firestore().collection('products');

  Future<List<Product>> getAllProducts() async {
    final QuerySnapshot query = await ref.orderBy('name', 'desc').get();
    final List<Product> allProducts = query.docs
        .map((DocumentSnapshot doc) => Product.fromDocument(doc))
        .toList();
    return allProducts;
  }

  Future<void> createProduct(Product product) async {
    return ref.doc(product.id).set(product.toJson(), SetOptions(merge: true));
  }

  Future<void> deleteProduct(String productID) {
    return ref.doc(productID).delete();
  }
}
