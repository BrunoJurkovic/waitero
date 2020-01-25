import 'package:flutter/widgets.dart';

@immutable
class CustomIconsData extends IconData {
  const CustomIconsData(int codePoint)
      : super(
          codePoint,
          fontFamily: 'CustomIcons',
        );
}

@immutable
class CustomIcons {
  CustomIcons._();

  // Generated code: do not hand-edit.
  static const IconData table = CustomIconsData(0xe000);
}
