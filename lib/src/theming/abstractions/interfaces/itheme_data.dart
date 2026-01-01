import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart';

/// Represents a theming data.
abstract interface class IThemeData {
  /// Icon to represent visually the theme context.
  final Icon icon;

  /// Color specified for the frame size display.
  final Color? frame;

  /// Unique theme identification for the theme manager.
  final String identifier;

  /// Contrast background color to highlight [icon].
  final Color iconBackground;

  /// Theming data for all application primary controls.
  final ThemingData controlTheming;

  /// Theming data for all application primary controls when they are at { error } state.
  final ThemingData controlErrorTheming;

  /// Theming data for all application primary controls when they are at { success } state.
  final ThemingData controlSuccessTheming;

  /// Creates a new [IThemeData] instance.
  const IThemeData(
    this.icon,
    this.frame,
    this.identifier,
    this.iconBackground,
    this.controlTheming,
    this.controlErrorTheming,
    this.controlSuccessTheming,
  );
}
