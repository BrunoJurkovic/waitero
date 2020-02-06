import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'package:waiteroclient/components/submit_button/submit_button.dart';
import 'package:waiteroclient/models/order.dart';
import 'package:waiteroclient/models/product.dart';
import 'package:waiteroclient/providers/cart.dart';
import 'package:waiteroclient/router/router.gr.dart';
import 'package:waiteroclient/screens/order/desktop/widgets/mini_cart/mini_cart_item.dart';
import 'package:waiteroclient/services/database/orders_repository.dart';
import 'package:waiteroclient/theme/style.dart';

class MiniCart extends StatefulWidget {
  const MiniCart({
    Key key,
    this.provider,
  }) : super(key: key);

  final CartProvider provider;

  @override
  _MiniCartState createState() => _MiniCartState();
}

class _MiniCartState extends State<MiniCart> {
  bool disabled = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: 400,
      child: Column(
        children: <Widget>[
          const SizedBox(height: 16),
          Text(
            'Cart',
            style: Style.common.copyWith(fontSize: 24),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: widget.provider.cartItems.length,
              itemBuilder: (BuildContext context, int index) {
                final Product product = widget.provider.cartItems[index];
                return MiniCartItem(product: product);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(32.0),
            child: SubmitButton(
              onPressed: () async {
                await Provider.of<OrdersRepository>(context, listen: false)
                    .sendOrder(
                  Order(
                    id: Uuid().v4(),
                    isCompleted: false,
                    tableID: Uri.base.queryParameters['tableID'],
                    timestamp: DateTime.now(),
                    productIDs: widget.provider.cartItems
                        .map((Product product) => product.id)
                        .toList(),
                  ),
                );
                widget.provider.clearCart();
                Router.navigator.pushNamed(Router.thanksPage);
                setState(() {
                  disabled = true;
                });
              },
              text: Text(
                !disabled ? 'Order' : 'Already ordered',
                textAlign: TextAlign.center,
                style: Style.common.copyWith(
                  fontSize: MediaQuery.of(context).size.height / 30,
                ),
              ),
              disabled: disabled,
              width: MediaQuery.of(context).size.width * 0.3,
              height: MediaQuery.of(context).size.height * 0.05,
              color: Colors.grey[300],
              gradient: const LinearGradient(
                colors: <Color>[
                  Color(0xFFEF7198),
                  Color(0xFFF296B7),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
