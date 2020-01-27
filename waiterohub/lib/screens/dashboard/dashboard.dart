import 'package:flutter/material.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:waitero/components/scaffold/custom_scaffold.dart';
import 'package:waitero/screens/dashboard/widgets/data_container.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Text(
                'Dashboard',
                style: TextStyle(
                  color: const Color(0xFF20212C),
                  fontWeight: FontWeight.w800,
                  fontFamily: 'Diodrum',
                  fontSize: 35.0,
                ),
              ),
            ),
            const SizedBox(height: 32),
            Text(
              'Analytical Overview',
              style: TextStyle(
                color: const Color(0xFF20212C),
                fontWeight: FontWeight.w600,
                letterSpacing: 0.6,
                fontFamily: 'Diodrum',
                fontSize: 24.0,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 32.0, top: 0),
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(35),
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            const DataContainer(
                              color1: Color(0xFFEF7198),
                              color2: Color(0xFFF296B7),
                              bottomText: '157',
                              topText: 'NEW ORDERS',
                              sideText: 'orders',
                              icon: Icon(
                                OMIcons.showChart,
                                size: 60,
                                color: Colors.white54,
                              ),
                            ),
                            const DataContainer(
                              color1: Color(0xFFBA82FF),
                              color2: Color(0xFFD0A3FF),
                              bottomText: '23',
                              topText: 'MENU ITEMS',
                              sideText: 'items',
                              icon: Icon(
                                OMIcons.restaurantMenu,
                                size: 60,
                                color: Colors.white54,
                              ),
                            ),
                            const DataContainer(
                              color1: Color(0xFF5EC999),
                              color2: Color(0xFF7EDDB9),
                              bottomText: '2.300',
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
                    ),
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
