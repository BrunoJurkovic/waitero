import 'package:flutter/material.dart';
import 'package:outline_material_icons/outline_material_icons.dart';


/*
  ! This widget is used for creating the custom gradient container that displays all of the counters.
  ? Ovaj widget se koristi za stvaranje gradient container-a koji prikazuje sve brojace (narudzbi, stvari na meni-u, itd.).
*/


class DataContainer extends StatelessWidget {
  const DataContainer({
    Key key,
    this.color1,
    this.color2,
    this.topText,
    this.bottomText,
    this.icon, this.sideText,
  }) : super(key: key);

  final Color color1;
  final Color color2;
  final String topText;
  final String bottomText; 
  final Icon icon;
  final String sideText;

  /*
  ! We pass some items through the constructor to make it reusable, such as gradient colors, text, icon, etc.
  ? Kroz constructor posaljemo neke stvari kako bi smo mogli reciklirati widget, kao sto su boje za gradient, text, ikone, itd.
*/

  @override
  Widget build(BuildContext context) {
    final Size mediaQuery = MediaQuery.of(context).size;
    return Container(
      height: mediaQuery.height * 0.14,
      width: mediaQuery.width * 0.21,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: color1,
            blurRadius: 20,
            // spreadRadius: 2,
            offset: Offset(mediaQuery.width * 0.001, mediaQuery.height * 0.005),
          ),
        ],
        gradient: LinearGradient(
          begin: Alignment.centerRight,
          end: Alignment.centerLeft,
          colors: <Color>[
            color1,
            color2,
          ],
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          icon,
          Column(
            // mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Text(
                  topText,
                  style: TextStyle(
                    fontFamily: 'Diodrum',
                    fontWeight: FontWeight.w600,
                    color: Colors.white54,
                    letterSpacing: 2,
                    fontSize: 14,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Row(
                  children: <Widget>[
                    Text(
                      bottomText,
                      style: TextStyle(
                        fontFamily: 'Diodrum',
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        fontSize: 32,
                      ),
                    ),
                    const SizedBox(
                      width: 7,
                    ),
                    Text(
                      sideText,
                      style: TextStyle(
                        fontFamily: 'Diodrum',
                        fontWeight: FontWeight.w600,
                        color: Colors.white54,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
