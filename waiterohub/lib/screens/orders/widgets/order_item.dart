import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:waitero/components/fade_in/fade_in.dart';
import 'package:waitero/screens/orders/widgets/indicator_dot.dart';
import 'package:waitero/services/database/orders_repo.dart';

/*
  ! OrderItem is a individual line for an order, has all of the necesary things for management to see where to deliver.
  ? OrderItem je jedan individualni red za narudzbu, sadrzi sve potrebne stavke kako bi management mogao znati gdje dostaviti narudzbu.
*/

class OrderItem extends StatefulWidget {
  const OrderItem({
    this.status,
    this.tableID,
    this.orderID,
    this.timestamp,
    this.shouldBeGrey,
  });

  final OrderStatus status;
  final String tableID;
  final String orderID;
  final DateTime timestamp;
  final bool shouldBeGrey;

  @override
  _OrderItemState createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  AudioPlayer audioPlayer = AudioPlayer();
  int temp;

  @override
  void initState() {
    Future<void>.delayed(
      Duration.zero,
      () async => temp = await audioPlayer.play(
          'https://raw.githubusercontent.com/BrunoJurkovic/waitero/dev/waiterohub/assets/sounds/notif.mp3'),
    );
    super.initState();
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final OrdersRepository orders = Provider.of<OrdersRepository>(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2),
      child: FutureBuilder<double>(
        future: orders.calculateItemCost(widget.orderID),
        builder: (BuildContext context, AsyncSnapshot<double> snapshot) {
          if (!snapshot.hasData) {
            return const SizedBox();
          }
          return ItemBody(
            orderID: widget.orderID,
            tableID: widget.tableID,
            status: widget.status,
            timestamp: widget.timestamp,
            total: snapshot.data,
            shouldBeGrey: widget.shouldBeGrey,
          );
        },
      ),
    );
  }
}

class ItemBody extends StatelessWidget {
  const ItemBody({
    Key key,
    @required this.orderID,
    @required this.tableID,
    @required this.status,
    @required this.timestamp,
    @required this.total,
    @required this.shouldBeGrey,
  }) : super(key: key);

  final String orderID;
  final String tableID;
  final OrderStatus status;
  final DateTime timestamp;
  final double total;
  final bool shouldBeGrey;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.05,
      width: MediaQuery.of(context).size.width * 0.75,
      child: Container(
        color: shouldBeGrey ? const Color(0xFFF8F7FC) : null,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              width: 150,
              child: FadeIn(
                delay: 0.45,
                child: Text(
                  '#${orderID?.substring(0, 8)?.toUpperCase()}',
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
              child: Container(
                width: 100,
                child: Text(
                  'TBL-$tableID',
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
                  key: ValueKey<OrderStatus>(status),
                  status: status,
                ),
              ),
            ),
            FadeIn(
              delay: 0.60,
              child: Container(
                width: 100,
                child: Text(
                  '$total \$',
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
              child: Container(
                width: 100,
                child: Text(
                  '${DateFormat('HH:mm').format(timestamp.toLocal())}',
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
      ),
    );
  }
}
