import 'package:csm_view/csm_view.dart';
import 'package:csm_view/src/common/enums.dart';
import 'package:flutter/foundation.dart';

/// [class] for [Domain] implementation.
///
/// this [class] works as a [utils], providing easier communication with the direct runtime platform API, simplifying
/// getting the current running platform, information or instructions.
final class Domain {
  /// Simplify to get the current running platform.
  static final TargetPlatform _platform = defaultTargetPlatform;

  /// Wheter currently is running web.
  static bool get isWeb => kIsWeb;

  /// Wheter currently is running mobile.
  static bool get isMobile => Comparer.isAny(
        _platform,
        <TargetPlatform>[
          TargetPlatform.android,
          TargetPlatform.fuchsia,
          TargetPlatform.iOS,
        ],
      );

  /// Wheter currently is running desktop.
  static bool get isDesktop => Comparer.isAny(
        _platform,
        <TargetPlatform>[
          TargetPlatform.linux,
          TargetPlatform.macOS,
          TargetPlatform.windows,
        ],
      );

  /// Gets the current running platform.
  static Platforms get context => isWeb
      ? Platforms.web
      : isMobile
          ? Platforms.mobile
          : Platforms.desktop;
}
