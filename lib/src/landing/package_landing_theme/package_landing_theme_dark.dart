import 'package:csm_view/csm_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' show Colors, Icons;

/// [implementation] for [LandingThemeB].
///
///
/// Defines a theme configuration implementation when the context is [light] theme.
class PackageLandingThemeDark extends LandingThemeB {
  /// Creates a new [PackageLandingThemeDark] instance.
  PackageLandingThemeDark([String? themeId])
      : super(
          themeId ?? 'package-landing-theme-dark',
          icon: Icon(Icons.dark_mode),
          iconBackground: Colors.black54,
          pageTheming: SimpleTheming(
            back: Colors.black87,
            fore: Colors.white,
            accent: Colors.grey.shade600,
          ),
          headerTheming: SimpleTheming(
            back: Colors.grey.shade600,
            fore: Colors.white,
            accent: Colors.white,
          ),
          welcomeCardTheming: SimpleTheming(
            back: Colors.grey.shade600,
            fore: Colors.white,
            accent: Colors.white,
          ),
        );
}
