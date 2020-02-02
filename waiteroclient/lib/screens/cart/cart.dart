import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:waiteroclient/components/scaffold/custom_scaffold.dart';
import 'package:waiteroclient/components/unsupported_platform/unsupported_platform.dart';
import 'package:waiteroclient/screens/cart/mobile/cart_mobile.dart';
import 'package:waiteroclient/screens/cart/tablet/cart_tablet.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: ResponsiveBuilder(
        builder: (BuildContext context, SizingInformation sizing) {
          switch (sizing.deviceScreenType) {
            case DeviceScreenType.Mobile:
              return const CartPageMobile();
            case DeviceScreenType.Tablet:
              return const CartPageTablet();
            case DeviceScreenType.Desktop:
              return const CartPageTablet();
            default:
              return const UnsupportedPlatform();
          }
        },
      ),
    );
  }
}