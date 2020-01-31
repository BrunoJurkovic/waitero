import 'package:flutter/material.dart';
import 'package:waitero/providers/table.dart';
import 'package:waitero/screens/tables/widgets/table_item.dart';

class TablesDisplay extends StatelessWidget {
  const TablesDisplay({
    Key key,
    @required this.isEditing, this.tables,
  }) : super(key: key);

  final bool isEditing;
  final List<RestaurantTable> tables;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: tables
          .map((RestaurantTable table) => TableItem(
                id: table.id,
                offset: table.position,
                qrCodeUrl: table.qrCodeURL,
                isEditing: isEditing,
              ))
          .toList(),
    );
  }
}