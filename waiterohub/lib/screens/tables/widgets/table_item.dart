import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:waitero/routing/router.gr.dart';
import 'package:waitero/services/database/tables_repo.dart';

class TableItem extends StatefulWidget {
  const TableItem({
    Key key,
    this.offset,
    this.qrCodeUrl,
    this.id,
    this.isRound,
    this.isEditing = false,
  }) : super(key: key);

  final Offset offset;
  final String qrCodeUrl;
  final String id;
  final bool isEditing;
  final bool isRound;

  @override
  _TableItemState createState() => _TableItemState();
}

class _TableItemState extends State<TableItem> {
  Offset offset = Offset.zero;
  bool isRound = false;

  @override
  void initState() {
    offset = widget.offset;
    isRound = widget.isRound;
    super.initState();
  }

  @override
  void didUpdateWidget(TableItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (offset != oldWidget.offset) {
      offset = widget.offset;
    }
    if (widget.isRound != oldWidget.isRound) {
      isRound = widget.isRound;
    }
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidthOffset = screenWidth / 1.43;
    final double screenHeightOffset = screenHeight / 1.205;
    final TablesRepository tablesRepository =
        Provider.of<TablesRepository>(context);

    return Container(
      child: Positioned(
        left: offset.dx,
        top: offset.dy,
        child: GestureDetector(
          onPanUpdate: (DragUpdateDetails details) {
            if (!widget.isEditing) {
              return;
            }
            if (offset.dx < 0) {
              offset = Offset(5, offset.dy);
              return;
            }
            if (offset.dx > screenWidthOffset) {
              offset = Offset(screenWidthOffset - 5, offset.dy);
              return;
            }
            if (offset.dy < 0) {
              offset = Offset(offset.dx, 0);
              return;
            }
            if (offset.dy > screenHeightOffset) {
              offset = Offset(offset.dx, screenHeightOffset - 5);
              return;
            }
            final Offset newOffset = Offset(
              offset.dx + details.delta.dx,
              offset.dy + details.delta.dy,
            );
            tablesRepository.updateLocalTableOffset(widget.id, newOffset);
            setState(() {
              offset = newOffset;
            });
          },
          onTap: () async {
            dynamic result = await Router.navigator.pushNamed(
              Router.tableDetails,
              arguments: TableDetailsArguments(
                id: widget.id,
                qrCodeURL: widget.qrCodeUrl,
                isRound: isRound,
              ),
            );
            await _updateShape(result as Map<String, dynamic>, context);
          },
          onPanCancel: () {
            print('canceled');
          },
          onPanEnd: (DragEndDetails endDetails) {
            print('ended');
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: !isRound ? BorderRadius.circular(12) : null,
              shape: isRound ? BoxShape.circle : BoxShape.rectangle,
              color: isRound ? Colors.brown[400] : Colors.brown,
            ),
            width: isRound ? 200 : 150,
            height: isRound ? 75 : 75,
            child: Center(
              child: Text(
                widget.id,
                style: TextStyle(
                  fontSize: 25.0,
                  fontFamily: 'Diodrum',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _updateShape(
      Map<String, dynamic> result, BuildContext context) async {
    if (result != null) {
      bool response;
      if (result['isRound'] == 'Circular') {
        response = true;
      } else {
        response = false;
      }
      await Provider.of<TablesRepository>(context, listen: false)
          .switchTableShape(widget.id, response);
    }
  }
}
