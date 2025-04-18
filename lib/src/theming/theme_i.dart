import 'package:flutter/material.dart';

/// Interface for [Theming] implementations.
///
/// Defines required behavior for a [Theming] implementation.
abstract interface class ThemeI {
  /// Unique theme identification for the theme manager.
  final String identifier;

  /// Color specified for the frame size display.
  final Color? frame;

  /// Creates a new [ThemeI] instance.
  const ThemeI(this.identifier, this.frame);
}
