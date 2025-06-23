import 'package:csm_view/src/landing/package_landing_theme/package_landing_theme_b.dart';
import 'package:csm_view/src/theming/models/simple_theming.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' show Colors, Icons;

///
class PackageLandingThemeLight extends LandingThemeB {
  ///
  PackageLandingThemeLight([String? themeId])
      : super(
          themeId ?? 'package-landing-theme-light',
          icon: Icon(Icons.light_mode),
          iconBackground: Colors.white60,
          pageTheming: SimpleTheming(
            back: Color(0xfff2f2f2),
            fore: Colors.black,
            accent: Colors.blue.shade900,
          ),
          headerTheming: SimpleTheming(
            back: Colors.blue.shade900,
            fore: Colors.white,
            accent: Colors.white70,
          ),
          welcomeCardTheming: SimpleTheming(
            back: Colors.blue.shade900,
            fore: Colors.white,
            accent: Colors.white70,
          ),
        );
}
