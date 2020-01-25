import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:waitero/providers/product.dart';

class ProductsRepository {
  CollectionReference ref = Firestore.instance.collection('products');

  Future<List<Product>> getAllProducts() async {
    final QuerySnapshot query =
        await ref.orderBy('name', descending: true).getDocuments();
    final List<Product> allProducts = query.documents
        .map((DocumentSnapshot doc) => Product.fromDocument(doc))
        .toList();
    return allProducts;
  }

  Future<void> createProduct(Product product) {
    return ref.document(product.id).setData(product.toJson(), merge: true);
  }

  Future<void> deleteProduct(String productID) {
    return ref.document(productID).delete();
  }
}
