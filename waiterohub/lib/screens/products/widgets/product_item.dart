import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:waitero/providers/product.dart';

/*
  ! This widget is used for showing an individual product item with an image which is cached locally.
  ? Ovaj widget se koristi za prikazivanje individualnog proizvoda sa slikom koja je cache-ana lokalno.
*/

class ProductItem extends StatelessWidget {
  const ProductItem({Key key, this.product}) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height * 0.15,
            child: CachedNetworkImage(
              imageUrl: product.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            child: Text(
              product.name,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: TextStyle(
                color: Colors.black,
                fontSize: 28,
                fontFamily: 'Diodrum',
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Text(
            '${product.price} USD',
            style: const TextStyle(
              color: Colors.black,
              fontSize: 22,
              fontFamily: 'Diodrum',
            ),
          ),
        ],
      ),
    );
  }
}
