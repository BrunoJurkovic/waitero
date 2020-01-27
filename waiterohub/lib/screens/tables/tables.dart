import 'package:flutter/material.dart';
import 'package:waitero/components/scaffold/custom_scaffold.dart';

class TablesPage extends StatefulWidget {
  const TablesPage({Key key}) : super(key: key);

  @override
  _TablesPageState createState() => _TablesPageState();
}

class _TablesPageState extends State<TablesPage> {
  Offset offset = Offset.zero;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidthOffset = screenWidth / 1.3;
    double screenHeightOffset = screenHeight / 1.4;

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
            Expanded(
              child: Container(
                width: screenWidthOffset,
                height: screenHeightOffset,
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      left: offset.dx,
                      top: offset.dy,
                      child: GestureDetector(
                        onPanUpdate: (DragUpdateDetails details) {
                          // manual positions
                          print(offset);
                          if (offset.dx < 0) {
                            offset = Offset(5, offset.dy);
                            return;
                          }
                          if (offset.dx > screenWidthOffset) {
                            offset = Offset(screenWidthOffset, offset.dy);
                            return;
                          }
                          if (offset.dy < 0) {
                            offset = Offset(offset.dx, 0);
                            return;
                          }
                          if (offset.dy > screenHeightOffset) {
                            offset = Offset(offset.dx, screenHeightOffset);
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
      ),
    );
  }
}
