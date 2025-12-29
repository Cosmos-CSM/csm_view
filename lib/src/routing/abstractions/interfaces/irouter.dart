import 'package:csm_view/csm_view.dart';

/// Represents a { View } routing context handler.
abstract interface class IRouter {
  /// Gets the [RouteData] from the given { View } application's [absolutePath].
  ///
  /// [absolutePath] - { View } application's path to get [RouteData].
  ///
  /// [allowLogs] - Whether the method must display logs.
  RouteData getRouteData(String absolutePath, [bool allowLogs]);

  /// Gets the absolute path calculation from a specific [RouteData] into the calculated [RouterBase] tree.
  ///
  /// [route] the required [RouteData]'s absolute path calculation.
  ///
  /// [allowLogs] whether the method can announce logs.
  String getAbsolutePath(RouteData route, [bool allowLogs]);

  /// Resolves development working route redirection.
  ///
  /// [routeData] - Target development route data.
  ///
  /// [currentPath] - Current { View } application's route path.
  ///
  /// [targetPath] - Routing request { View } application's target path.
  ///
  /// [allowLogs] - Whether the method must display logs.
  String? resolveDevRedirection(RouteData routeData, String currentPath, String? targetPath, [bool allowLogs]);
}
