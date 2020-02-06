import 'package:flutter/material.dart';

class SubmitButton extends StatelessWidget {
  const SubmitButton(
      {Key key,
      this.gradient,
      this.onPressed,
      this.text,
      this.width,
      this.height})
      : super(key: key);

  final Gradient gradient;
  final VoidCallback onPressed;
  final String text;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: width,
        height: height,
        child: FlatButton(
          onPressed: onPressed,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
          padding: const EdgeInsets.all(0.0),
          child: Ink(
            decoration: BoxDecoration(
              gradient: gradient,
              borderRadius: const BorderRadius.all(
                Radius.circular(80.0),
              ),
            ),
            child: Container(
              constraints: const BoxConstraints(
                minWidth: 88.0,
                minHeight: 36.0,
              ),
              alignment: Alignment.center,
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 25.0,
                  fontFamily: 'Diodrum',
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ));
  }
}
