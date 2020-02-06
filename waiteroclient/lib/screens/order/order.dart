import 'package:flutter/material.dart';
import 'package:waiteroclient/components/scaffold/custom_scaffold.dart';
import 'package:waiteroclient/components/unsupported_platform/unsupported_platform.dart';
import 'package:waiteroclient/screens/order/index.dart';
import 'package:waiteroclient/util/breakpoints.dart';

class OrderPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          if (constraints.maxWidth >= Breakpoints.desktopBreakpoint) {
            return const OrderPageDesktop();
          } else if (constraints.maxWidth >= Breakpoints.tabletBreakpoint) {
            return const OrderPageTablet();
          } else if (constraints.maxWidth >= Breakpoints.mobileBreakpoint) {
            return const OrderPageMobile();
          }
          return const UnsupportedPlatform();
        },
      ),
    );
  }
}
