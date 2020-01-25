import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
    final Size rBox = gKey.currentContext.size;
    print("SIZE:" + rBox.toString());
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return CustomScaffold(
      body: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Text(
              'Tables',
              style: GoogleFonts.alata(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 30.0,
              ),
            ),
          ),
          Expanded(
            child: Stack(
              key: gKey,
              overflow: Overflow.visible,
              children: <Widget>[
                Positioned(
                  left: offset.dx,
                  top: offset.dy,
                  child: GestureDetector(
                    onPanUpdate: (DragUpdateDetails details) {
                      fun();
                      print('OFFSET: ${offset.dx}, ${offset.dy}');
                      if (offset.dx < 0) {
                        offset = Offset(offset.dx + 1, offset.dy);
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
        ],
      ),
    );
  }
}
