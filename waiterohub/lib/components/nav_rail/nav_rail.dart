import 'package:flutter/material.dart';
import 'package:waitero/components/custom_icons/custom_icons.dart';
import 'package:waitero/routing/router.gr.dart';

class NavRail extends StatefulWidget {
  const NavRail({
    Key key,
    this.fab,
    this.body,
  }) : super(key: key);

  final FloatingActionButton fab;
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
          width: 72,
          margin: const EdgeInsets.only(left: 16, top: 8),
          child: Column(
            children: <Widget>[
              widget.fab ?? Container(),
              NavRailItem(
                icon: Icons.view_agenda,
                label: 'Orders',
                route: Router.orders,
              ),
              NavRailItem(
                icon: Icons.attach_money,
                label: 'Products',
                route: Router.manageProducts,
              ),
              NavRailItem(
                icon: CustomIcons.table,
                label: 'Tables',
                route: Router.tables,
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
      child: Container(
        height: 100,
        width: 100,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              icon,
              size: 48,
            ),
            Visibility(
              visible: true,
              child: Text(
                label,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
