import 'package:flutter/widgets.dart';

// ! EN: This class/file is used for generating a custom icon for our table tab.
// ? HR: Ovaj class nam sluzi kako bi imali mogucnost pokazati nasu specijalnu ikonu za tab u kojem uredujemo stolove.


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
