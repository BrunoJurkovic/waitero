import 'package:firebase/firestore.dart';

class Product {
  Product({
    this.id,
    this.name,
    this.price,
    this.imageUrl,
  });

  factory Product.fromDocument(DocumentSnapshot doc) {
    final Map<String, dynamic> data = doc.data();
    return Product(
      id: data['productId'] as String,
      name: data['name'] as String,
      price: data['price'] as String,
      imageUrl: data['imageUrl'] as String,
    );
  }

  Map<String, String> toJson() {
    return <String, String>{
      'productId': id,
      'imageUrl': imageUrl,
      'name': name,
      'price': price,
    };
  }

  final String id;
  final String name;
  final String price;
  final String imageUrl;
  // final string description;

}
