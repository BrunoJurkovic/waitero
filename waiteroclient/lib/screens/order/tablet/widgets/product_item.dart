import 'package:flutter/material.dart';
import 'package:waiteroclient/models/product.dart';
import 'package:waiteroclient/theme/style.dart';

class ProductItemTablet extends StatelessWidget {
  const ProductItemTablet({Key key, this.product, this.onPressed})
      : super(key: key);

  final Product product;
  final Function(Product) onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.05,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
      ),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          onTap: () => onPressed(product),
          borderRadius: BorderRadius.circular(15),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
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
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: Style.common.copyWith(fontSize: 22),
                  ),
                ),
                Text(
                  '${product.price} USD',
                  maxLines: 1,
                  style: Style.common.copyWith(fontSize: 16),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
