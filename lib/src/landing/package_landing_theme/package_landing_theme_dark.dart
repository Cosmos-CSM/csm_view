import 'package:csm_view/csm_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' show Colors, Icons;

/// [implementation] for [PackageLandingThemeB].
///
///
/// Defines a theme configuration implementation when the context is [light] theme.
class PackageLandingThemeDark extends PackageLandingThemeB {
  /// Creates a new [PackageLandingThemeDark] instance.
  PackageLandingThemeDark([String? themeId])
      : super(
          themeId ?? 'package-landing-theme-dark',
          icon: Icon(Icons.dark_mode),
          iconBackground: Colors.black54,
          layoutHeaderColor: Colors.blue,
        );
}
