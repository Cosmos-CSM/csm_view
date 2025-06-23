import 'package:flutter/material.dart';

/// Interface for [Theming] implementations.
///
/// Defines required behavior for a [Theming] implementation.
abstract interface class ThemeDataI {
  /// Icon to represent visually the theme context.
  final Icon icon;

  /// Contrast background color to highlight [icon].
  final Color iconBackground;

  /// Unique theme identification for the theme manager.
  final String identifier;

  /// Color specified for the frame size display.
  final Color? frame;

  /// Creates a new [ThemeDataI] instance.
  const ThemeDataI(this.icon, this.iconBackground, this.identifier, this.frame);
}

/// [Abstract] for [theming] implementations.
///
/// Defines handlers and common members for all theming implementations.
abstract class ThemeDataB implements ThemeDataI {
  /// Icon to represent visually the theme context.
  @override
  final Icon icon;

  /// Contrast background color to highlight [icon].
  @override
  final Color iconBackground;

  /// Unique theme identification for the theme manager.
  @override
  final String identifier;

  /// Color specified for the frame size display.
  @override
  final Color? frame;

  /// Creates a new [ThemeDataB] instance.
  const ThemeDataB(
    this.identifier, {
    this.frame,
    required this.icon,
    required this.iconBackground,
  });
}
