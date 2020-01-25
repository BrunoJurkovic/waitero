import 'package:flutter/material.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:waitero/components/custom_icons/custom_icons.dart';
import 'package:waitero/routing/router.gr.dart';

class NavRail extends StatefulWidget {
  const NavRail({
    Key key,
    this.body,
  }) : super(key: key);

  final Widget body;

  @override
  _NavRailState createState() => _NavRailState();
}

class _NavRailState extends State<NavRail> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: 250,
          decoration: const BoxDecoration(
            color: Color(0xFF6621F9),
            borderRadius: BorderRadius.horizontal(
              right: Radius.circular(35),
            ),
          ),
          child: Column(
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.only(top: 32.0),
                child: Text(
                  'Waitero Hub',
                  style: TextStyle(
                    fontSize: 30.0,
                    color: Colors.white,
                    fontFamily: 'Substance',
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    NavRailItem(
                      icon: OMIcons.viewAgenda,
                      label: 'ORDERS',
                      route: Router.orders,
                    ),
                    NavRailItem(
                      icon: OMIcons.attachMoney,
                      label: 'PRODUCTS',
                      route: Router.manageProducts,
                    ),
                    NavRailItem(
                      icon: CustomIcons.table,
                      label: 'TABLES',
                      route: Router.orders,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Expanded(child: widget.body),
      ],
    );
  }
}

class NavRailItem extends StatelessWidget {
  const NavRailItem({
    Key key,
    @required this.icon,
    @required this.label,
    @required this.route,
    this.isSelected = false,
  }) : super(key: key);

  final IconData icon;
  final String route;
  final String label;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Router.navigator.pushNamed(route);
      },
      splashColor: Colors.red,
      borderRadius: const BorderRadius.horizontal(left: Radius.circular(50)),
      child: Container(
        height: 50,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.horizontal(left: Radius.circular(50)),
        ),
        child: ListTile(
          leading: Icon(
            icon,
            color: Colors.white,
          ),
          title: Text(
            label,
            style: const TextStyle(
              fontFamily: 'Substance',
              fontSize: 14,
              letterSpacing: 2.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
