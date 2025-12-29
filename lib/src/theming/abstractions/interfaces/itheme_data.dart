import 'package:flutter/material.dart';

/// Represents a theming data.
abstract interface class IThemeData {
  /// Icon to represent visually the theme context.
  final Icon icon;

  /// Contrast background color to highlight [icon].
  final Color iconBackground;

  /// Unique theme identification for the theme manager.
  final String identifier;

  /// Color specified for the frame size display.
  final Color? frame;

  /// Creates a new [IThemeData] instance.
  const IThemeData(this.icon, this.iconBackground, this.identifier, this.frame);
}
