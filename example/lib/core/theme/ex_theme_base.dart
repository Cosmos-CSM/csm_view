import 'dart:ui';

import 'package:csm_view/csm_view.dart';

abstract class EXThemeBase extends ThemeB {
  final Color backgroundColor;

  const EXThemeBase(
    super.identifier, {
    required this.backgroundColor,
  });
}
