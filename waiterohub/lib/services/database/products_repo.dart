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

  Future<int> countProducts() async {
    final List<Product> products = await getAllProducts();
    return products.length;
  }

  Future<double> getProductPrice(String id) async {
    final QuerySnapshot query = await ref.where('productId', isEqualTo: id).getDocuments();
    final String stringPrice = query.documents[0]['price'] as String;
    return double.parse(stringPrice.substring(1, stringPrice.length));

  }

  Future<void> createProduct(Product product) {
    return ref.document(product.id).setData(product.toJson(), merge: true);
  }

  Future<void> deleteProduct(String productID) {
    return ref.document(productID).delete();
  }
}
