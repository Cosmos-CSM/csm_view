import 'package:csm_view/csm_view.dart';
import 'package:flutter/foundation.dart';

/// [util] class for Widget Adaption.
///
/// Provides functions to calculate and return results based on the current runtime platform.
final class WidgetAdaption {
  /// Calculates the current runtime platform to return the one that matches the platform.
  static T adaptProperty<T>({
    required T defaultValue,
    T? browserValue,
    T? mobileValue,
    T? desktopValue,
    T? androidValue,
    T? iosValue,
    T? linuxValue,
    T? windowsValue,
  }) {
    T result = defaultValue;
    switch (Domain.context) {
      case Platforms.web:
        result = browserValue ?? defaultValue;
      case Platforms.mobile:
        result = (mobileValue ?? (defaultTargetPlatform == TargetPlatform.iOS ? iosValue : androidValue)) ?? defaultValue;
      case Platforms.desktop:
        result = (desktopValue ?? (defaultTargetPlatform == TargetPlatform.windows ? windowsValue : linuxValue)) ?? defaultValue;
    }

    return result;
  }
}
