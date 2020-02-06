import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:waitero/components/fade_in/fade_in.dart';
import 'package:waitero/providers/order.dart';
import 'package:waitero/providers/product.dart';
import 'package:waitero/screens/orders/widgets/indicator_dot.dart';
import 'package:waitero/services/database/orders_repo.dart';
import 'package:waitero/services/database/products_repo.dart';

/*
  ! OrderItem is a individual line for an order, has all of the necesary things for management to see where to deliver.
  ? OrderItem je jedan individualni red za narudzbu, sadrzi sve potrebne stavke kako bi management mogao znati gdje dostaviti narudzbu.
*/

class OrderItem extends StatefulWidget {
  const OrderItem({
    @required this.order,
    @required this.status,
    @required this.shouldBeGrey,
  });

  final Order order;
  final OrderStatus status;
  final bool shouldBeGrey;

  @override
  _OrderItemState createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  List<Product> products = <Product>[];
  int temp = 0;
  AudioPlayer audioPlayer = AudioPlayer();

  @override
  void initState() {
    Future<void>.delayed(
      Duration.zero,
      () async => temp = await audioPlayer.play(
        'https://raw.githubusercontent.com/BrunoJurkovic/waitero/dev/waiterohub/assets/sounds/notif.mp3',
      ),
    );
    super.initState();
    _getAllProducts();
  }

  Future<void> _getAllProducts() async {
    await Future<void>.delayed(Duration.zero);
    final ProductsRepository repo =
        Provider.of<ProductsRepository>(context, listen: false);
    for (final String id in widget.order.productIDs.cast<String>()) {
      products.add(await repo.getProduct(id));
    }
  }

  @override
  Widget build(BuildContext context) {
    final OrdersRepository orders = Provider.of<OrdersRepository>(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2),
      child: FutureBuilder<double>(
        future: orders.calculateItemCost(widget.order.id),
        builder: (BuildContext context, AsyncSnapshot<double> snapshot) {
          if (!snapshot.hasData) {
            return const SizedBox();
          }
          return ItemBody(
            order: widget.order,
            status: widget.status,
            total: snapshot.data,
            shouldBeGrey: widget.shouldBeGrey,
            products: products,
          );
        },
      ),
    );
  }
}

class ItemBody extends StatefulWidget {
  const ItemBody({
    Key key,
    @required this.status,
    @required this.total,
    @required this.shouldBeGrey,
    @required this.order,
    @required this.products,
  }) : super(key: key);

  final Order order;
  final OrderStatus status;
  final double total;
  final bool shouldBeGrey;
  final List<Product> products;

  @override
  _ItemBodyState createState() => _ItemBodyState();
}

class _ItemBodyState extends State<ItemBody> {
  bool isClicked = false;

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;

    return AnimatedContainer(
      curve: Curves.fastOutSlowIn,
      duration: const Duration(milliseconds: 700),
      height: isClicked ? height * 0.15 : height * 0.05,
      width: MediaQuery.of(context).size.width * 0.75,
      color: widget.shouldBeGrey ? const Color(0xFFF8F7FC) : Colors.white,
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          onTap: () {
            setState(() {
              isClicked = !isClicked;
            });
          },
          onLongPress: () {
            Provider.of<OrdersRepository>(context, listen: false)
                .toggleComplete(widget.order);
          },
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  SizedBox(
                    width: 150,
                    child: FadeIn(
                      delay: 0.45,
                      child: Text(
                        '#${widget.order.id.substring(0, 8).toUpperCase()}',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontFamily: 'Diodrum',
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                  FadeIn(
                    delay: 0.5,
                    child: SizedBox(
                      width: 100,
                      child: Text(
                        'TBL-${widget.order.tableID}',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontFamily: 'Diodrum',
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                  FadeIn(
                    delay: 0.55,
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 400),
                      child: IndicatorWidget(
                        key: ValueKey<OrderStatus>(widget.status),
                        status: widget.status,
                      ),
                    ),
                  ),
                  FadeIn(
                    delay: 0.60,
                    child: SizedBox(
                      width: 100,
                      child: Text(
                        '${widget.total} \$',
                        textAlign: TextAlign.right,
                        style: const TextStyle(
                          fontFamily: 'Diodrum',
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                  FadeIn(
                    delay: 0.65,
                    child: SizedBox(
                      width: 100,
                      child: Text(
                        '${DateFormat('HH:mm').format(widget.order.timestamp.toLocal())}',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontFamily: 'Diodrum',
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Visibility(
                visible: isClicked,
                child: Container(
                  height: 100,
                  margin: const EdgeInsets.only(left: 15),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: widget.order.productIDs.length,
                    itemBuilder: (BuildContext context, int index) {
                      final Product product = widget.products[index];
                      return Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          children: <Widget>[
                            Image(
                              image: NetworkImage(product.imageUrl),
                              width: 100,
                              height: 75,
                            ),
                            Text(
                              product.name,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                                fontFamily: 'Diodrum',
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
