import 'package:flutter/material.dart';
import 'package:waiteroclient/theme/style.dart';

class SubmitButton extends StatelessWidget {
  const SubmitButton({
    Key key,
    @required this.onPressed,
    @required this.text,
    this.color,
    this.gradient,
    this.disabled = false,
    this.width = 100,
    this.height = 50,
  }) : super(key: key);

  final Gradient gradient;
  final VoidCallback onPressed;
  final Widget text;
  final bool disabled;
  final Color color;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: FlatButton(
        onPressed: () {
          if (!disabled) {
            onPressed();
          }
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(80.0),
        ),
        padding: const EdgeInsets.all(0.0),
        child: Ink(
          decoration: BoxDecoration(
            gradient: !disabled ? gradient : null,
            color: disabled ? color : Colors.transparent,
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
            child: text,
          ),
        ),
      ),
    );
  }
}
