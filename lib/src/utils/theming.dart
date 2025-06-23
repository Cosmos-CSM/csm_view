import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart';

/// [utils] class implementation for [Theming].
///
///
/// Provides interaction and easier functions to interact with the [ThemeManagerI] instance
/// handling the whole application context, useful when only one interaction is needed with the manager.
final class Theming {
  /// Gets the current application {theme}.
  static TBase get<TBase extends ThemeDataB>(BuildContext buildContext) {
    return ThemeManager.of(buildContext).castData();
  }
}
