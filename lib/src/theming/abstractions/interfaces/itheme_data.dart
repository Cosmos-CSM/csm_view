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

  /// Theming data for all the application pages.
  final ThemingData page;

  /// Theming data for all application primary controls.
  final ThemingData control;

  /// Theming data for all application primary controls when they are at { error } state.
  final ThemingData controlError;

  /// Theming data for all application primary controls when they are at { success } state.
  final ThemingData controlSuccess;

  /// Creates a new [IThemeData] instance.
  const IThemeData(
    this.icon,
    this.page,
    this.frame,
    this.identifier,
    this.iconBackground,
    this.control,
    this.controlError,
    this.controlSuccess,
  );
}
