import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:waitero/components/custom_icons/custom_icons.dart';
import 'package:waitero/routing/router.gr.dart';

int _selectedIndex = 0;

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
  void _onItemSelected(int index) {
    _selectedIndex = index;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: 250,
          decoration: const BoxDecoration(
            color: Color(0xFFFEFEFE),
          ),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 32.0),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.10,
                  width: MediaQuery.of(context).size.width * 0.10,
                  child: Image.asset(
                    'assets/images/logo.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 32.0),
                child: Text(
                  'Waitero Hub',
                  style: TextStyle(
                    color: Color(0xFF20212C),
                    fontWeight: FontWeight.w800,
                    fontFamily: 'Diodrum',
                    fontSize: 30.0,
                  ),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  primary: false,
                  padding: const EdgeInsets.symmetric(vertical: 100),
                  child: Column(
                    children: <Widget>[
                      NavRailItem(
                        icon: OMIcons.barChart,
                        label: 'Dashboard',
                        route: Router.dashboard,
                        index: 0,
                        onTap: () => _onItemSelected(0),
                      ),
                      const SizedBox(height: 20),
                      NavRailItem(
                        icon: OMIcons.viewAgenda,
                        label: 'Orders',
                        route: Router.orders,
                        index: 1,
                        onTap: () => _onItemSelected(1),
                      ),
                      const SizedBox(height: 20),
                      NavRailItem(
                        icon: OMIcons.attachMoney,
                        label: 'Products',
                        route: Router.manageProducts,
                        index: 2,
                        onTap: () => _onItemSelected(2),
                      ),
                      const SizedBox(height: 20),
                      NavRailItem(
                        icon: CustomIcons.table,
                        label: 'Tables',
                        route: Router.orders,
                        index: 3,
                        onTap: () => _onItemSelected(3),
                      ),
                    ],
                  ),
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
    @required this.index,
    @required this.onTap,
  }) : super(key: key);

  final IconData icon;
  final String route;
  final String label;
  final int index;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      margin: const EdgeInsets.only(left: 16),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          onTap: () {
            Router.navigator.pushNamed(route);
            onTap();
          },
          borderRadius:
              const BorderRadius.horizontal(left: Radius.circular(50)),
          child: ListTile(
            leading: Icon(
              icon,
              color: _selectedIndex == index
                  ? Colors.blueAccent
                  : Colors.grey[500],
            ),
            title: Text(
              label,
              style: TextStyle(
                fontFamily: 'Diodrum',
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color:
                    _selectedIndex == index ? Colors.black : Colors.grey[500],
              ),
            ),
            trailing: _selectedIndex == index
                ? Container(
                    height: 20,
                    width: 5,
                    color: Colors.blueAccent,
                  )
                : const SizedBox(),
          ),
        ),
      ),
    );
  }
}
