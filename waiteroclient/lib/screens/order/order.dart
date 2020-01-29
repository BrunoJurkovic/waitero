import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:waiteroclient/components/scaffold/custom_scaffold.dart';
import 'package:waiteroclient/screens/order/index.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({Key key}) : super(key: key);

  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget buildUnsupportedPlatform() {
      return const Center(
        child: Text('This device is unsupported.'),
      );
    }

    return CustomScaffold(
      body: ResponsiveBuilder(
        builder: (BuildContext context, SizingInformation sizing) {
          switch (sizing.deviceScreenType) {
            case DeviceScreenType.Mobile:
              return const OrderPageMobile();
            case DeviceScreenType.Tablet:
              return const OrderPageTablet();
            case DeviceScreenType.Desktop:
              return const OrderPageDesktop();
            default:
              return buildUnsupportedPlatform();
          }
        },
      ),
    );
  }
}
