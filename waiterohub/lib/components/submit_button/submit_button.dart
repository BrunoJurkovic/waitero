import 'package:flutter/material.dart';

class SubmitButton extends StatelessWidget {
  const SubmitButton({
    Key key,
    this.gradient,
    this.onPressed,
  }) : super(key: key);

  final Gradient gradient;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: MediaQuery.of(context).size.width * 0.25,
        height: MediaQuery.of(context).size.height * 0.1,
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
              child: const Text(
                'Update Tables',
                style: TextStyle(
                  fontSize: 25.0,
                  fontFamily: 'Diodrum',
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ));
  }
}
