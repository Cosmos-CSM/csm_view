import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart' as material;
import 'package:go_router/go_router.dart' hide RouteData;

/// Type definition for a dictionary of route tree.
typedef _RouteTree = Map<Route, String>;

/// Type definition for a dictionary of route tree entry.
typedef _RouteTreeEntry = MapEntry<Route, String>;

/// This helper provides several functionallities for Cosmos Foundation routing.
final class Router {
  /// [Router] scope [Console] debugger printer tool.
  static final Console _console = Console('csm-router');

  /// Internal reference to look for ignore redirection property in the extra routing info.
  final String _kIgnoreRedirectionKey = "i-r${DateTime.now().toString()}";

  /// --> Already singleton inited object.
  ///
  /// Stores the local static instance of the Manager that will be used along all its invokes.
  static Router? _instance;
  Router._();

  /// Gathers the current application [RouteDriver] manager instance.
  ///
  /// If you know it's the first time that you gather this singleton object (init gather), you must invoke
  /// [initNavigator] method to initialize the internal [NavigatorState] to manage the routing, and recommended
  /// if you're using [CSMRouteBase] invoke [initRouterTree] to initialize the route tree calculation that is a
  /// dependency to the correct functionallity along [CSMRouteBase] nodes and layouts routing.
  static Router get i => _instance ??= Router._();

  /// --> Local manager navigator subscribed along the main application and the driver manager usage.
  ///
  /// This is subscribed after [initNavigator] static method that is already subscribed to the
  /// initialization method of [Cosmos] default application methods, for custom applications
  /// that uses several managers from [Cosmos] nor using [CosmosApp] or [CosmosRouting]. Needs to
  /// invoke the method [initNavigator] to initialize dependencies.
  static NavigationState? _navigationState;

  /// --> Local manager navigator subscribed along the main application and the driver manager usage.
  ///
  /// This is subscribed after [initNavigator] static method that is already subscribed to the
  /// initialization method of [Cosmos] default application methods, for custom applications
  /// that uses several managers from [Cosmos] nor using [CosmosApp] or [CosmosRouting]. Needs to
  /// invoke the method [initNavigator] to initialize dependencies.
  static NavigationState get _nav {
    if (_navigationState != null) return _navigationState as NavigationState;
    throw Exception('NavigatorState dependency lack. Left use of [initNavigator] method');
  }

  /// Stores the calculation of absolute paths for the giving routing tree initialized in the application.
  static final _RouteTree _absoluteContext = <Route, String>{};

  /// Stores the calculation of absolute paths as a log details object to announce.
  static final Map<String, Object?> _absoluteContextDetails = <String, Object?>{};

  /// Indicates wheter internal logging is enabled
  static bool _loggerOn = false;

  /// Indicates wheter [initRouterTree] already was called.
  static bool _treeOn = false;

  /// Indicates wheter [initNavigator] already was called.
  static bool _devResolverOn = false;

  //* --> Public static methods

  /// Initializes the mandatory dependency for navigation along the router management implementation of your application.
  ///
  /// [navigationStateKey] : [NavigatorState] key access that the manager will use along the application to resolve [Router].
  ///
  /// [logging] : Whether the method can announce logs.
  static void initNavigator(NavigationState navigationStateKey, [bool logging = false]) {
    _navigationState ??= navigationStateKey;
    if (i._canLog(logging)) {
      _console.success(
        'Navigator inited',
        info: <String, dynamic>{
          'Naviagtor State Hash': _nav.hashCode,
        },
      );
    }
  }

  /// Initializes the [Router] tree used for this application runtime routing calculations.
  ///
  /// [routes] : Route tree subscribed to the application routing options that will be used
  /// to calculate the internal route tree for [CosmosRouting] impls.
  ///
  /// [log] : Wheter the method can print logs.
  static void initRouterTree(List<RouteB> routes, [bool log = false]) {
    if (_treeOn) return;
    for (RouteB route in routes) {
      _resolveAbsolutePath(route, '');
    }

    _treeOn = true;
    if (i._canLog(log)) {
      _console.success(
        'Router tree successfully inited',
        info: <String, Object?>{
          'route-tree': _absoluteContext.map(
            (Route key, String value) {
              return MapEntry<String, Object?>("(${key.name} | ${key.path} | ${key.hashCode})", value);
            },
          ),
        },
      );
    }
  }

  /// Sets the global context of logs for [RouteDriver] invokes.
  static void turnLogs(bool enable) {
    _loggerOn = enable;
  }

  //* --> Public instance methods

  /// Gets the absolute path calculation from a specific [Route] into the calculated [Router] tree.
  ///
  ///
  /// [route] the required [Route]'s absolute path calculation.
  ///
  /// [logging] whether the method can announce logs.
  String getAbsolutePath(Route route, [bool logging = false]) {
    final bool canLog = _canLog(logging);
    if (!_treeOn) {
      throw Exception('Router tree not initialized yet');
    }

    if (!_absoluteContext.containsKey(route)) {
      if (canLog) {
        _console.warning(
          'Route not in route tree',
          info: <String, dynamic>{
            'route': route,
            'route-tree': _absoluteContextDetails,
          },
        );
      }
      throw Exception('Route not in Router tree');
    }
    return _absoluteContext[route] as String;
  }

  /// Gets the [Route] in the [Router] tree with the given [absolutePath].
  ///
  ///
  /// [absolutePath] absolute path to get the [Route].
  ///
  /// [logging] wheter the method can announce logs.
  Route getRoute(String absolutePath, [bool logging = false]) {
    for (_RouteTreeEntry calculation in _absoluteContext.entries) {
      if (absolutePath == calculation.value) return calculation.key;
    }

    if (_canLog(logging)) {
      _console.warning(
        'Absolute path not in Router tree',
        info: <String, dynamic>{
          'Absolute Path': absolutePath,
          'Router Tree': _absoluteContextDetails,
        },
      );
    }
    throw Exception('Absolute path not in Router tree');
  }

  /// Resolves the development redirection configured at the [Router].
  ///
  ///
  /// [route] specified development working [Route].
  ///
  /// [currentPath] the current application path.
  ///
  /// [targetPath] the target path where the application wants to go.
  String? resolveDevelopment(Route route, String currentPath, String? targetPath, [bool logging = false]) {
    if (!_absoluteContext.containsKey(route)) {
      if (_canLog(logging)) {
        _console.warning(
          'Configured development Route isn\' in the Router tree',
          info: <String, dynamic>{
            'Development Route': route,
            'Router Tree': _absoluteContextDetails,
          },
        );
      }
      return null;
    }

    final String devPath = _absoluteContext[route] as String;
    if (currentPath.isEmpty || (devPath == targetPath)) return devPath;
    return null;
  }

  /// Checks if the [resolveDevelopment] is ready to be triggered.
  ///
  ///  Notes:
  ///   - Doesn't contain logs.
  bool devRedirectNode() {
    if (_devResolverOn) return false;

    return (_devResolverOn = true);
  }

  /// Indicates the [Router] to perform a [Route] resolution, pointing the given [route].
  ///
  ///
  /// [route] target desired [Route] information.
  ///
  /// [ignoreRedirection] whether the [Router] should avoid any [Redirection] trigger.
  ///
  /// [push] whether the [Router] should push into the history the target [route] or just go directly to it removing all the previous [Router] history.
  ///
  /// [extra] extra data shared along [Route] resolutions.
  ///
  /// [logging] whether the nethod can print logs.
  void go(
    Route route, {
    bool ignoreRedirection = false,
    bool logging = false,
    bool push = false,
    DataMap? extra,
  }) {
    extra ??= <String, dynamic>{};

    if (ignoreRedirection) {
      extra[_kIgnoreRedirectionKey] = true;
    }

    final bool canLog = _canLog(logging);
    final material.NavigatorState? navState = _nav.currentState;
    final material.BuildContext? navCtx = navState?.context;
    final material.BuildContext? navigation = _nav.currentContext;

    if (navCtx == null || !navCtx.mounted || navigation == null || !navigation.mounted) {
      if (canLog) {
        _console.warning('Can\'t perform Router go cause the Navigator is defunct');
      }
      return;
    }

    if (push) {
      GoRouter.of(navCtx).pushNamed(route.name, extra: extra);
    } else {
      GoRouter.of(navCtx).goNamed(route.name, extra: extra);
    }
    if (canLog) {
      _console.success(
        'Success drive',
        info: <String, Object?>{
          'Route': route.hashCode,
          'Route Name': route.name,
          'Navigation State': navigation.hashCode,
          'Route Extra': extra,
          'Is Push': push,
        },
      );
    }
  }

  /// Indicates the [Router] to perform a pop action removing the top-most resolved [Route] being back to the previous one.
  ///
  /// [logging] whether the method can print logs.
  void pop([bool logging = true]) {
    final material.NavigatorState? navState = _nav.currentState;
    final material.BuildContext? navCtx = navState?.context;
    final material.BuildContext? navigation = _nav.currentContext;
    if (navCtx == null || !navCtx.mounted || navigation == null || !navigation.mounted) {
      if (logging) {
        _console.warning('Can\'t perform driving cause the Navigator is defunct');
      }
      return;
    }

    if (navigation.canPop()) {
      navigation.pop();
    }
  }

  /// Indicates the [Router] to remove all its routing history entries.
  void dropHistory() {
    _nav.currentState?.popUntil(
      (material.Route<void> route) => route.isActive,
    );
  }

  //* --> Private static methods

  /// Calculates an absolute path based on the parent absolute path and the current node [Route].
  ///
  ///
  /// [routeNode] absolute path fromn the desired [RouteB].
  ///
  /// [parentAbsolute] the parent node absolute path calculation to join them.
  ///
  /// Notes:
  ///   - Doesn't contain logs.
  static void _resolveAbsolutePath(RouteB routeNode, String parentAbsolute) {
    if (routeNode is RouteNodeB) {
      Route route = routeNode.route;
      String relativePath = route.path;
      if (relativePath.startsWith('/')) {
        relativePath = relativePath.replaceFirst('/', '');
      }
      String absolutePath = '$parentAbsolute/$relativePath';
      // --> Adding to absolute context
      _absoluteContext[route] = absolutePath;
      // --> Adding to absolute context details
      _absoluteContextDetails[route.toString()] = absolutePath;
      parentAbsolute = absolutePath;
    }
    for (RouteB routeLeef in routeNode.routes) {
      _resolveAbsolutePath(routeLeef, parentAbsolute);
    }
  }

  //* --> Private instance methods.

  /// Checks if the [Router] operations can be logged.
  ///
  /// [logging] whether the method can log operations.
  bool _canLog([bool logging = false]) {
    if (!logging) return _loggerOn;
    return logging;
  }
}
