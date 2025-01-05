/// File that includes complex calculations to adapt properties depending on the running platform.
library;

import 'package:csm_view/csm_view.dart';
import 'package:csm_view/src/common/enums/csm_platforms.dart';
import 'package:flutter/foundation.dart';

/// Calculates the adaptive value for a given set of values given, automatically will return the correct
/// result value depending on the given values for each platform or device.
T adaptProperty<T>({
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
  switch (CSMTerraformer.context) {
    case CSMPlatforms.web:
      result = browserValue ?? defaultValue;
    case CSMPlatforms.mobile:
      result = (mobileValue ?? (defaultTargetPlatform == TargetPlatform.iOS ? iosValue : androidValue)) ?? defaultValue;
    case CSMPlatforms.desktop:
      result = (desktopValue ?? (defaultTargetPlatform == TargetPlatform.windows ? windowsValue : linuxValue)) ?? defaultValue;
  }

  return result;
}
