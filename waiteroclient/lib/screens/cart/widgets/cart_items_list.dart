import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'package:waiteroclient/components/submit_button/submit_button.dart';
import 'package:waiteroclient/models/order.dart';
import 'package:waiteroclient/models/product.dart';
import 'package:waiteroclient/providers/cart.dart';
import 'package:waiteroclient/router/router.gr.dart';
import 'package:waiteroclient/screens/cart/widgets/cart_item.dart';
import 'package:waiteroclient/services/database/orders_repository.dart';
import 'package:waiteroclient/theme/style.dart';

class CartItemsList extends StatefulWidget {
  const CartItemsList({
    Key key,
    @required this.provider,
  }) : super(key: key);

  final CartProvider provider;

  @override
  _CartItemsListState createState() => _CartItemsListState();
}

class _CartItemsListState extends State<CartItemsList> {
  bool disabled = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: ListView.separated(
            itemCount: widget.provider.cartItems.length,
            primary: false,
            shrinkWrap: true,
            padding: const EdgeInsets.all(24),
            itemBuilder: (_, int index) {
              final Product product = widget.provider.cartItems[index];
              return CartItem(product: product);
            },
            separatorBuilder: (_, int index) => const SizedBox(height: 10),
          ),
        ),
        SubmitButton(
          onPressed: () {
            Provider.of<OrdersRepository>(context, listen: false)
                .sendOrder(Order(
              id: Uuid().v4(),
              isCompleted: false,
              tableID: Uri.base.queryParameters['tableID'] ?? '0',
              timestamp: DateTime.now(),
              productIDs: widget.provider.cartItems
                  .map((Product product) => product.id)
                  .toList(),
            ));
            Router.navigator.pushNamed(Router.thanksPage);
            setState(() {
              disabled = true;
            });
          },
          disabled: disabled,
          text: Text(
            !disabled ? 'Order' : 'Already ordered',
            textAlign: TextAlign.center,
            style: Style.common.copyWith(
              fontSize: MediaQuery.of(context).size.height / 25,
            ),
          ),
          color: Colors.grey[300],
          width: MediaQuery.of(context).size.width * 0.6,
          height: MediaQuery.of(context).size.height * 0.05,
          gradient: const LinearGradient(
            colors: <Color>[
              Color(0xFFEF7198),
              Color(0xFFF296B7),
            ],
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
