import 'package:flutter/material.dart';

import 'app_extension.dart';

class AppTheme {
  static final light = ThemeData.light().copyWith(
    extensions: [
      lightAppColors,
    ],
  );

  static final lightAppColors = AppColorsExtension(
    primary: const Color(0xff179537), //
    background: const Color(0xffffffff), //
    maincolor: const Color(0xff000000), //
    bordercolor: const Color(0xffA9ACBB),
    subTextcolor: const Color(0xffDB5B5B),
    mainTextcolor: const Color(0xff606060),
    containercolor: const Color(0xff00A8A8),
  );
}
