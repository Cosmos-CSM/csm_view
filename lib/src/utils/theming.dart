import 'package:csm_view/csm_view.dart';

/// [utils] class implementation for [Theming].
///
///
/// Provides interaction and easier functions to interact with the [ThemeManagerI] instance
/// handling the whole application context, useful when only one interaction is needed with the manager.
final class Theming {
  /// Internal refrence to get easely the [ThemeManagerI] implementation.
  static ThemeManagerI<TThemeB> _themeManager<TThemeB extends ThemeB>() {
    return Injector.getThemeManager<TThemeB>();
  }

  /// Gets the current [ThemeManagerI] theme context.
  static TThemeB get<TThemeB extends ThemeB>() {
    return _themeManager<TThemeB>().get();
  }
}
