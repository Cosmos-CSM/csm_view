import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart';

/// Enum for [Platforms].
///
/// Defines an enumerator for a [Platforms] implementation.
///
///[Platforms] concept: describes a possible platform for the current application running context.
enum Platforms {
  web('Browser', Colors.amber),
  mobile('Mobile Device', Colors.deepOrangeAccent),
  desktop('Desktop Device', Colors.greenAccent);

  /// Descriptive name.
  final String name;

  /// Color identification.
  final Color color;

  const Platforms(this.name, this.color);

  @override
  String toString() => name;
}

/// Enum for [CSMStates].
///
/// Defines an enumerator for [CSMStates] implementation.
///
/// [CSMStates] concept: describes a control state.
enum CSMStates {
  hovered,
  selected,
  none;

  /// Evaluates the values per state.
  T evaluate<T>({
    T? onHover,
    T? onSelect,
    required T onIdle,
  }) {
    switch (this) {
      case CSMStates.hovered:
        return onHover ?? onIdle;
      case CSMStates.selected:
        return onSelect ?? onIdle;
      default:
        return onIdle;
    }
  }

  /// Evaluates the factories per state.
  T evaluateFactories<T>({
    T Function()? onHover,
    T Function()? onSelect,
    required T Function() onIdle,
  }) {
    switch (this) {
      case CSMStates.hovered:
        return onHover?.call() ?? onIdle();
      case CSMStates.selected:
        return onSelect?.call() ?? onIdle();
      default:
        return onIdle();
    }
  }

  /// Evaluates the given [options] to calculate a resolved [CSMGenericThemeOptions] by the current state.
  InputControlTheming evaluateTheme(StateControlTheming options) {
    switch (this) {
      case CSMStates.hovered:
        return options.hovered ?? options.main;
      case CSMStates.selected:
        return options.selected ?? options.main;
      default:
        return options.main;
    }
  }
}
