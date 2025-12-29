import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart';

/// Represents a theming data.
abstract class ThemeDataBase implements IThemeData {
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

  /// Creates a new instance.
  const ThemeDataBase(
    this.identifier, {
    this.frame,
    required this.icon,
    required this.iconBackground,
  });
}
