import 'package:flutter/material.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'package:waitero/components/scaffold/custom_scaffold.dart';
import 'package:waitero/providers/table.dart';
import 'package:waitero/screens/tables/widgets/table_display.dart';
import 'package:waitero/services/database/tables_repo.dart';

class TablesPage extends StatefulWidget {
  const TablesPage({Key key}) : super(key: key);

  @override
  _TablesPageState createState() => _TablesPageState();
}

class _TablesPageState extends State<TablesPage> {
  Offset offset = Offset.zero;
  bool isEditing = false;
  List<RestaurantTable> tablesList;
  List<RestaurantTable> dbTables;
  bool init = false;
  List<RestaurantTable> cachedTables = <RestaurantTable>[];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!init) {
      Future<void>.delayed(Duration.zero, () async {
        await Provider.of<TablesRepository>(context, listen: false).init();
      });
      init = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    tablesList = Provider.of<TablesRepository>(context,).tables;
    final cachedTables = tablesList;

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
                      const SizedBox(width: 20),
                      Visibility(
                        visible: !isEditing,
                        child: IconButton(
                          icon: Icon(OMIcons.edit),
                          onPressed: () {
                            setState(() {
                              isEditing = true;
                            });
                          },
                          iconSize: 32,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Visibility(
                        visible: isEditing,
                        child: Row(
                          children: <Widget>[
                            IconButton(
                              icon: Icon(OMIcons.add),
                              onPressed: () {
                                Provider.of<TablesRepository>(context,
                                        listen: false)
                                    .createTable(
                                  RestaurantTable(
                                    id: Uuid().v4(),
                                    position: const Offset(0, 0),
                                  ),
                                );
                              },
                              iconSize: 32,
                            ),
                            const SizedBox(width: 6),
                            IconButton(
                              icon: Icon(OMIcons.check),
                              onPressed: () {
                                setState(() {
                                  isEditing = false;
                                });
                              },
                              iconSize: 32,
                            ),
                            const SizedBox(width: 6),
                            IconButton(
                              icon: Icon(OMIcons.cancel),
                              onPressed: () async {
                                // final List<RestaurantTable> tables =
                                //     await Provider.of<TablesRepository>(context,
                                //             listen: false)
                                //         .getAllTables();
                                tablesList.clear();
                                tablesList = cachedTables;
                                isEditing = false;
                                setState(() {});
                              },
                              iconSize: 32,
                            ),
                            const SizedBox(width: 6),
                          ],
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
                // child: FutureBuilder<List<RestaurantTable>>(
                //   future: tableList,
                //   builder: (BuildContext context,
                //       AsyncSnapshot<List<RestaurantTable>> snapshot) {
                //     if (!snapshot.hasData) {
                //       return SizedBox(); // ! add the universal loader here
                //     }
                //     return TablesDisplay(
                //       isEditing: isEditing,
                //       tables: snapshot.data,
                //     );
                //   },
                // ),
                child: TablesDisplay(
                  isEditing: isEditing,
                  tables: tablesList,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
