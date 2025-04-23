import 'package:flutter/material.dart';

/// Interface for [Theming] implementations.
///
/// Defines required behavior for a [Theming] implementation.
abstract interface class ThemeI {
  /// Icon to represent visually the theme context.
  final Icon icon;

  /// Contrast background color to highlight [icon].
  final Color iconBackground;

  /// Unique theme identification for the theme manager.
  final String identifier;

  /// Color specified for the frame size display.
  final Color? frame;

  /// Creates a new [ThemeI] instance.
  const ThemeI(this.icon, this.iconBackground, this.identifier, this.frame);
}
