import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart' show Color;

///
abstract class PackageLandingThemeB extends ThemeB {
  /// Background color for the [PackageLanding] layout header.
  final Color layoutHeaderColor;

  /// Creates a new [PackageLandingThemeB] instance.
  const PackageLandingThemeB(
    super.identifier, {
    required super.icon,
    required super.iconBackground,
    required this.layoutHeaderColor,
  });
}
