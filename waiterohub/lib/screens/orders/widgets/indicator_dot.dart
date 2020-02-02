import 'package:flutter/material.dart';

/*
  ! We make a enum to simplify the states in which the indicator dot can be in.
  ? Napravimo enum kako bi smo mogli pojednostaviti stanja u kojem loading indicator moze biti.
*/

enum OrderStatus {
  Completed,
  Unfinished,
}

/*
  ! The IndicatorWidget displays the status of the order.
  ? Ovaj widget pokazuje stanje narudzbe.
*/

class IndicatorWidget extends StatelessWidget {
  const IndicatorWidget({Key key, this.status}) : super(key: key);

  final OrderStatus status;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.03,
      width: MediaQuery.of(context).size.width * 0.1,
      child: Card(
        color: status == OrderStatus.Completed
            ? const Color(0xFF5EC999).withOpacity(0.25)
            : const Color(0xFFEF7198).withOpacity(0.25),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            IndicatorDot(status: status),
            Text(
              status == OrderStatus.Completed ? 'COMPLETED' : 'UNFINISHED',
              style: TextStyle(
                color: status == OrderStatus.Completed
                    ? const Color(0xFF5EC999)
                    : const Color(0xFFEF7198),
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

/*
  ! To simplify things, we seperated the IndicatorWidget in another class for clarity.
  ? Kako bi smo pojednostavili stvari, odvojili dio smo IndicatorWidget-a u ovaj class.
*/

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
