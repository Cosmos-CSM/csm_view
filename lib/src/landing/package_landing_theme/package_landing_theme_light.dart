import 'package:csm_view/src/landing/package_landing_theme/package_landing_theme_b.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' show Colors, Icons;

///
class PackageLandingThemeLight extends PackageLandingThemeB {
  ///
  PackageLandingThemeLight([String? themeId])
      : super(
          themeId ?? 'package-landing-theme-light',
          icon: Icon(Icons.light_mode),
          iconBackground: Colors.white60,
          layoutHeaderColor: Colors.blueGrey,
        );
}
