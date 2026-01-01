part of '../navigation_layout.dart';

/// {reactor} class.
///
/// Implements reaction state management for [NavigationLayout] navigation menu visibility toogling.
final class _NavigationLayourNavigationReactor extends ReactorBase {
  /// Whether currently the Navigation Menu is visible.
  bool _isOpen = true;

  /// Toogles the current Navigation Menu state.
  void toogle() {
    _isOpen = !_isOpen;
    react();
  }
}
