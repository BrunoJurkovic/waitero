import 'package:flutter/material.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:waitero/screens/dashboard/widgets/data_container.dart';

class InfoWidgets extends StatelessWidget {
  const InfoWidgets({
    Key key, this.snapshot,
  }) : super(key: key);

  final AsyncSnapshot<Map<String, dynamic>> snapshot;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            DataContainer(
              color1: const Color(0xFFEF7198),
              color2: const Color(0xFFF296B7),
              bottomText: '${snapshot.data['ordersToday']}',
              topText: 'NEW ORDERS',
              sideText: 'orders',
              icon: Icon(
                OMIcons.showChart,
                size: 60,
                color: Colors.white54,
              ),
            ),
            DataContainer(
              color1: const Color(0xFFBA82FF),
              color2: const Color(0xFFD0A3FF),
              bottomText:
                  '${snapshot.data['productCount']}',
              topText: 'MENU ITEMS',
              sideText: 'items',
              icon: Icon(
                OMIcons.restaurantMenu,
                size: 60,
                color: Colors.white54,
              ),
            ),
            DataContainer(
              color1: const Color(0xFF5EC999),
              color2: const Color(0xFF7EDDB9),
              bottomText:
                  '${snapshot.data['ordersMonthly']}',
              topText: 'MONTHLY ORDERS',
              sideText: 'orders',
              icon: Icon(
                OMIcons.barChart,
                size: 60,
                color: Colors.white54,
              ),
            ),
          ],
        ),
      ],
    );
  }
}