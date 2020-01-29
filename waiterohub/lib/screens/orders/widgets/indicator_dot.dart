import 'package:flutter/material.dart';

enum OrderStatus {
  Completed,
  Unfinished,
}

class IndicatorWidget extends StatelessWidget {
  const IndicatorWidget({Key key, this.status}) : super(key: key);

  final OrderStatus status;

  @override
  Widget build(BuildContext context) {
    return Container(
            height: MediaQuery.of(context).size.height * 0.03,
            width: MediaQuery.of(context).size.width * 0.1,
            child: Card(
              color: Color(0xFF5EC999).withOpacity(0.25),
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  const IndicatorDot(
                    status: OrderStatus.Completed,
                  ),
                  Text(
                    'COMPLETED',
                    style: TextStyle(
                      color: Color(0xFF5EC999),
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Diodrum',
                    ),
                  )
                ],
              ),
            ),
          );
  }
}

class IndicatorDot extends StatelessWidget {
  const IndicatorDot({Key key, this.status}) : super(key: key);

  final OrderStatus status;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: status == OrderStatus.Completed
            ? const Color(0xFF5EC999)
            : const Color(0xFFEF7198),
        shape: BoxShape.circle,
      ),
      height: 16,
      width: 16,
    );
  }
}
