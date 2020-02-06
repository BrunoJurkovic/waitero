import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:waiteroclient/components/scaffold/custom_scaffold.dart';
import 'package:waiteroclient/providers/cart.dart';
import 'package:waiteroclient/screens/cart/widgets/cart_items_list.dart';
import 'package:waiteroclient/theme/style.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Cart',
          style: Style.common,
        ),
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        brightness: Brightness.light,
        backgroundColor: const Color(0xFFF8F7FC),
        elevation: 0,
      ),
      body: Consumer<CartProvider>(
        builder: (BuildContext context, CartProvider repo, _) {
          return Visibility(
            visible: repo.cartItems.isNotEmpty,
            child: CartItemsList(provider: repo),
            replacement: Center(
              child: Text(
                'No items in cart',
                style: Style.common.copyWith(
                  fontSize: MediaQuery.of(context).size.height / 20,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
