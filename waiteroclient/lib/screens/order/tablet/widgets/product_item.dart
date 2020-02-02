import 'package:flutter/material.dart';
import 'package:waiteroclient/models/product.dart';

class ProductItemTablet extends StatelessWidget {
  const ProductItemTablet({Key key, this.product}) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return InkWell(

      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.brown,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height * 0.1,
              child: Image(
                image: NetworkImage(product.imageUrl),
              ),
            ),
            const SizedBox(height: 8),
            Container(
              child: Text(
                product.name,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 22,
                  fontFamily: 'Diodrum',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Text(
              '${product.price} USD',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontFamily: 'Diodrum',
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
