import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:waitero/providers/product.dart';

/*
  ! In this file we manage everything related to products.
  ? U ovoj datoteci upravljamo svime sto je vezano za proizvode.
*/

class ProductsRepository {
  ///!EN: We get a ref to the database at '/products/'.
  ///
  ///?HR: Nabavimo ref za databazu na '/products/'.
  CollectionReference ref = Firestore.instance.collection('products');

  ///!EN: This function returns all of the products, first it queries the database by name,
  ///! then it uses [.map] to cycle through all of the products, and returns a list of products.
  ///
  ///?HR: Ova funkcija vrati listu svih proizvoda, prvo napravi query databaze po sorti imenu,
  ///? onda koristi [.map] da vrti kroz sve proizovde, i onda vrati listu proizovda.
  Future<List<Product>> getAllProducts() async {
    final QuerySnapshot query =
        await ref.orderBy('name', descending: true).getDocuments();
    final List<Product> allProducts = query.documents
        .map((DocumentSnapshot doc) => Product.fromDocument(doc))
        .toList();
    return allProducts;
  }

  ///!EN: This function returns a [int] which is the number of all products in the database,
  ///! it saves the list of [Product] in a variable, and returns a [.length] of the list.
  ///
  ///?HR: Ova funkcija vrati [int], to je broj koji predstavlja kolicinu proizovda u databazi,
  ///? prvo spremi listu [Product] u varijabli, i onda zove [.length] na nju, pa vrati to.
  Future<int> countProducts() async {
    final List<Product> products = await getAllProducts();
    return products.length;
  }

  ///!EN: This function returns a price of a product. First it makes a query where 'productID' is
  ///! equal to the wanted id, then it checks the price of the said document.
  ///
  ///?HR: Ova funkcija vrati cijenu proizvoda. Prvo napravi query gdje je 'productId' jednak
  ///? trazenom proizvodu, i onda izvadi cijenu tog proizovda.
  Future<double> getProductPrice(String id) async {
    final QuerySnapshot query =
        await ref.where('productId', isEqualTo: id).getDocuments();
    final String stringPrice = query.documents[0]['price'] as String;
    return double.parse(stringPrice.substring(1, stringPrice.length));
  }

  ///!EN: This function creates a product and pushes it to the database.
  ///
  ///?HR: Ova funkcija stvori novi proizvod, i posalje ga u databazu.
  Future<void> createProduct(Product product) {
    return ref.document(product.id).setData(product.toJson(), merge: true);
  }

  ///!EN: This function deletes the product from the database.
  ///
  ///?HR: Ova funkcija izbrise proizvod iz databaze.
  Future<void> deleteProduct(String productID) {
    return ref.document(productID).delete();
  }
}
