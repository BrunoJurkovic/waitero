import 'package:flutter/material.dart';
import 'package:waitero/components/scaffold/custom_scaffold.dart';

class TablesPage extends StatefulWidget {
  const TablesPage({Key key}) : super(key: key);

  @override
  _TablesPageState createState() => _TablesPageState();
}

class _TablesPageState extends State<TablesPage> {
  Offset offset = Offset.zero;
  GlobalKey gKey = GlobalKey();

  void fun() {
    final RenderBox rBox = gKey.currentContext.findRenderObject() as RenderBox;
    final Size size = rBox.size;
    print(size);
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return CustomScaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Text(
                'Tables',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Diodrum',
                  fontSize: 30.0,
                ),
              ),
            ),
          ),
          Flexible(
            flex: 2,
            child: Container(
              key: gKey,
              child: Stack(
                children: <Widget>[
                  Positioned(
                    left: offset.dx,
                    top: offset.dy,
                    child: GestureDetector(
                      onPanUpdate: (DragUpdateDetails details) {
                        fun();
                        // manual positions
                        print(offset);
                        if (offset.dx < 0) {
                          offset = Offset(offset.dx + 1, offset.dy);
                          return;
                        }
                        if (offset.dx > 1090) {
                          offset = Offset(offset.dx - 1, offset.dy);
                          return;
                        }
                        if (offset.dy < 0) {
                          offset = Offset(offset.dx, offset.dy + 1);
                          return;
                        }
                        if (offset.dy > 640) {
                          offset = Offset(offset.dx, offset.dy - 1);
                          return;
                        }
                        setState(() {
                          offset = Offset(offset.dx + details.delta.dx,
                              offset.dy + details.delta.dy);
                        });
                      },
                      child: Container(
                        color: Colors.blue,
                        width: 100,
                        height: 100,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
