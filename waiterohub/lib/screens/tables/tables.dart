import 'package:flutter/material.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:provider/provider.dart';
import 'package:waitero/components/scaffold/custom_scaffold.dart';
import 'package:waitero/providers/table.dart';
import 'package:waitero/screens/tables/widgets/table_display.dart';
import 'package:waitero/screens/tables/widgets/table_item.dart';
import 'package:waitero/services/database/tables_repo.dart';

class TablesPage extends StatefulWidget {
  const TablesPage({Key key}) : super(key: key);

  @override
  _TablesPageState createState() => _TablesPageState();
}

class _TablesPageState extends State<TablesPage> {
  Offset offset = Offset.zero;

  bool isEditing = false;
  Future<List<RestaurantTable>> tableList;

  @override
  void initState() {
    WidgetsBinding.instance.scheduleFrameCallback((_) {
      tableList = Provider.of<TablesRepository>(context).getAllTables();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    final TablesRepository tables = Provider.of<TablesRepository>(context);

    return CustomScaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Table Management',
                    style: TextStyle(
                      color: const Color(0xFF20212C),
                      fontWeight: FontWeight.w800,
                      fontFamily: 'Diodrum',
                      fontSize: 35.0,
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: IconButton(
                          icon: isEditing
                              ? Icon(OMIcons.check)
                              : Icon(OMIcons.edit),
                          onPressed: () {
                            setState(() {
                              isEditing = !isEditing;
                            });
                          },
                          iconSize: 32,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 6),
                        child: IconButton(
                          icon: Icon(OMIcons.add),
                          onPressed: () {},
                          iconSize: 32,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                width: screenWidth / 1.286,
                height: screenHeight / 1.35,
                child: FutureBuilder<List<RestaurantTable>>(
                  future: tableList,
                  builder: (BuildContext context,
                      AsyncSnapshot<List<RestaurantTable>> snapshot) {
                    if (!snapshot.hasData) {
                      return SizedBox(); // ! add the universal loader here
                    }
                    return TablesDisplay(
                      isEditing: isEditing,
                      tables: snapshot.data,
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
