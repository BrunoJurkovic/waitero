import 'package:flutter/material.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:provider/provider.dart';
import 'package:waitero/components/scaffold/custom_scaffold.dart';
import 'package:waitero/providers/table.dart';
import 'package:waitero/routing/router.gr.dart';
import 'package:waitero/screens/tables/widgets/table_display.dart';
import 'package:waitero/services/database/tables_repo.dart';

class TablesPage extends StatefulWidget {
  const TablesPage({Key key}) : super(key: key);

  @override
  _TablesPageState createState() => _TablesPageState();
}

class _TablesPageState extends State<TablesPage> {
  bool _isEditing = false;
  Map<String, RestaurantTable> _tablesList;
  bool _init = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_init) {
      Future<void>.delayed(Duration.zero, () async {
        Provider.of<TablesRepository>(context, listen: false).init();
      });
      _init = true;
    }
  }

  Future<bool> shouldPop() async {
    print('shouldPop called');
    if (!_isEditing) {
      return true;
    }
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          content: const Text(
            'Discard changes?',
            style: TextStyle(
              fontSize: 14.0,
              fontFamily: 'Diodrum',
              fontWeight: FontWeight.w600,
            ),
          ),
          actions: <Widget>[
            MaterialButton(
              child: const Text('Yes'),
              onPressed: () => Router.navigator.pop(true),
            ),
            MaterialButton(
              child: const Text('No'),
              onPressed: () => Router.navigator.pop(false),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return WillPopScope(
      onWillPop: shouldPop,
      child: CustomScaffold(
        body: Consumer<TablesRepository>(
          builder: (BuildContext context, TablesRepository repo, Widget _) {
            _tablesList = repo.tables;
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 16.0, left: 32),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      const Text(
                        'Table Management',
                        style: TextStyle(
                          color: Color(0xFF20212C),
                          fontWeight: FontWeight.w800,
                          fontFamily: 'Diodrum',
                          fontSize: 35.0,
                        ),
                      ),
                      Row(
                        children: <Widget>[
                          const SizedBox(width: 20),
                          Visibility(
                            visible: !_isEditing,
                            child: IconButton(
                              icon: Icon(OMIcons.edit),
                              onPressed: () {
                                setState(() {
                                  _isEditing = true;
                                });
                              },
                              iconSize: 32,
                            ),
                          ),
                          const SizedBox(width: 6),
                          Visibility(
                            visible: _isEditing,
                            child: Row(
                              children: <Widget>[
                                IconButton(
                                  icon: Icon(OMIcons.add),
                                  onPressed: () {
                                    repo.createLocalTable(
                                      RestaurantTable(
                                          id: repo.getNextID().toString(),
                                          position: const Offset(0, 0),
                                          isRound: false),
                                    );
                                  },
                                  iconSize: 32,
                                ),
                                const SizedBox(width: 6),
                                IconButton(
                                  icon: Icon(OMIcons.check),
                                  onPressed: () async {
                                    await repo.sendTables();
                                    setState(() {
                                      _isEditing = false;
                                    });
                                  },
                                  iconSize: 32,
                                ),
                                const SizedBox(width: 6),
                                IconButton(
                                  icon: Icon(OMIcons.cancel),
                                  onPressed: () {
                                    _isEditing = false;
                                    repo.discardChanges();
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
                    child: TablesDisplay(
                      isEditing: _isEditing,
                      tables: _tablesList,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
