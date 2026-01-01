import 'package:csm_view/csm_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' show Colors, Icons;

/// [implementation] for [LandingThemeB].
///
///
/// Defines a theme configuration implementation when the context is [light] theme.
class PackageLandingThemeDark extends PackageLandingThemeBase {
  /// Creates a new [PackageLandingThemeDark] instance.
  PackageLandingThemeDark([String? themeId])
      : super(
          themeId ?? 'package-landing-theme-dark',
          icon: Icon(Icons.dark_mode),
          iconBackground: Colors.black54,
          pageTheming: ThemingData(
            back: Colors.black87,
            fore: Colors.white,
            accent: Colors.grey.shade600,
          ),
          headerTheming: ThemingData(
            back: Colors.grey.shade600,
            fore: Colors.white,
            accent: Colors.white,
          ),
          welcomeCardTheming: ThemingData(
            back: Colors.grey.shade600,
            fore: Colors.white,
            accent: Colors.white,
          ),
          control: ThemingData(
            back: Colors.black,
            fore: Colors.white,
            accent: Colors.grey,
          ),
          controlError: ThemingData(
            back: Colors.transparent,
            fore: Colors.red,
            accent: Colors.redAccent,
          ),
          controlSuccess: ThemingData(
            back: Colors.transparent,
            fore: Colors.green,
            accent: Colors.greenAccent,
          ),
          page: ThemingData(
            back: Colors.black,
            fore: Colors.white,
            accent: Colors.black87,
          ),
        );
}
