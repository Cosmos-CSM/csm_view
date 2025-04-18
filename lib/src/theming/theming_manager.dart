import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart';

/// Internal alias for [effects] functions that listen at theme changes for statefull widgets.
typedef Effect<TThemeB extends ThemeB> = void Function(TThemeB theme);

/// [Exception] thrown when the [ThemeManager] internal [ValueNotifier] wasn't correctly inited.
final class _InitException implements Exception {
  /// Creates a new [_InitException] instance.
  const _InitException();

  @override
  String toString() {
    return 'Cosmos theme manager isn\'t initialized yet'
        '\n This ocurr when you tried to use or access methods that depends on the value listener from the theme manager'
        'without configuring the correct properties to the CosmossApp to create/initialize the manager';
  }
}

///
abstract interface class ThemeManagerI<TThemeB extends ThemeB> {
  /// Gets the current application [theme] loaded.
  TThemeB get();

  /// Changes the current application [theme] for the one stored that matches the given [identifier].
  ///
  /// [identifier] new theme key binding.
  TThemeB change(String identifier);

  TThemeB addEffect(UniqueKey ref, Effect<TThemeB> effect);
}

/// [Manager] implementation for application theming handling, handles operations about change, restore, get theme proeprties
/// along application runtime.
///
/// [TThemeB] type of the customization base theme implementation.
final class ThemeManager<TThemeB extends ThemeB> implements ThemeManagerI<TThemeB> {
  /// Stores the private reference for the static theme collections provided by the configuration.
  final List<ThemeB> _themes = <ThemeB>[];

  /// Stores internal references for [effects] listeners.
  final Map<UniqueKey, Effect<TThemeB>> _effects = <UniqueKey, Effect<TThemeB>>{};

  /// Stores the default theme implementation to be used.
  final TThemeB _defaultTheme;

  /// Stores the reference for the global [ValueNotifier] where all the listeners are subscribed to.
  ///
  /// NOTE: DON'T USE DIRECTLY THIS TO NOTIFY ALL LISTENERS ABOUT A CHANGE, GET IT FROM [notifier] AS IT IS SANITIZED.
  ValueNotifier<ThemeB>? _notifier;

  /// Validates and returns the correct object to handle listeners notifications when the
  /// theme has changed.
  ///
  /// NOTE: Preferrely avoid use it, use it just in specific complex cases, if you have
  /// a [StatefulWidget] that needs update the theme after a change and after its state is setup.
  /// you can subscribe an [updateEffect] to the method [get] as the next example:
  /// ```dart
  ///   CosmosThemeBase? theme = getTheme(
  ///     updateEffect: setState(() => {{ `your state update` }}),
  ///   );
  /// ```
  ///
  ///
  /// RECOMMENDED USE (For [StatefulWidget]):
  /// '''dart
  ///   "State"
  ///   late CosmosThemeBase theme;
  ///
  ///   @override
  ///   void initState() {
  ///     super.initState();
  ///     theme = getTheme<'ThemeBase>(
  ///       updateEffect: updateThemeEffect
  ///     );
  ///   }
  ///
  ///   @override
  ///   void dispose() {
  ///     disposeGetTheme<'ThemeBase>(updateThemeEffect);
  ///     super.dispose();
  ///   }
  ///   void updateThemeEffect(ThemeBase effect) => setState(() {});
  /// '''
  ValueNotifier<ThemeB> get notifier {
    if (_notifier == null) throw const _InitException();
    return _notifier as ValueNotifier<ThemeB>;
  }

  /// Creates a new [ThemeManager] instance.
  ThemeManager(this._defaultTheme, List<TThemeB> themes) {
    _themes.addAll(themes);
    _notifier = ValueNotifier<ThemeB>(_defaultTheme);
  }

  @override
  TThemeB get() {
    return notifier.value as TThemeB;
  }

  @override
  TThemeB change(String identifier) {
    ThemeB? base = _themes.where((ThemeB element) => element.identifier == identifier).firstOrNull;

    if (base == null) throw Exception('The identifier wasn\'t found in the themes subscribed');
    notifier.value = base;
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        for (MapEntry<UniqueKey, Effect<TThemeB>> entry in _effects.entries) {
          entry.value(get());
        }
      },
    );
    return base as TThemeB;
  }

  @override
  TThemeB addEffect(UniqueKey ref, Effect<TThemeB> effect) {
    _effects.putIfAbsent(ref, () => effect);
    return get();
  }
}
