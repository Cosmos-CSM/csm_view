import 'package:csm_view/src/landing/abstractions/bases/package_landing_theme_base.dart';
import 'package:csm_view/src/theming/models/theming_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' show Colors, Icons;

///
class PackageLandingThemeLight extends PackageLandingThemeBase {
  ///
  PackageLandingThemeLight([String? themeId])
      : super(
          themeId ?? 'package-landing-theme-light',
          icon: Icon(Icons.light_mode),
          iconBackground: Colors.white60,
          pageTheming: ThemingData(
            back: Color(0xfff2f2f2),
            fore: Colors.black,
            accent: Colors.blue.shade900,
          ),
          headerTheming: ThemingData(
            back: Colors.blue.shade900,
            fore: Colors.white,
            accent: Colors.white70,
          ),
          welcomeCardTheming: ThemingData(
            back: Colors.blue.shade900,
            fore: Colors.white,
            accent: Colors.white70,
          ),
          controlTheming: ThemingData(
            back: Colors.black,
            fore: Colors.white,
            accent: Colors.grey,
          ),
          controlErrorTheming: ThemingData(
            back: Colors.transparent,
            fore: Colors.red,
            accent: Colors.redAccent,
          ),
          controlSuccessTheming: ThemingData(
            back: Colors.transparent,
            fore: Colors.green,
            accent: Colors.greenAccent,
          ),
        );
}
