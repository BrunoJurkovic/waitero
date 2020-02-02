import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:waiteroclient/models/product.dart';

class ProductItemMobile extends StatelessWidget {
  const ProductItemMobile({Key key, this.product}) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.brown,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height * 0.17,
            child: Image(
              image: NetworkImage(product.imageUrl),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            product.name,
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontFamily: 'Diodrum',
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            '${product.price} USD',
            style: TextStyle(
              color: Colors.black,
              fontSize: 14,
              fontFamily: 'Diodrum',
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
