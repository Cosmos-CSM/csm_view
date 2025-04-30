import 'package:csm_view/csm_view.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' hide Router, Route;
import 'package:go_router/go_router.dart' hide RouteData;

part '_router_listener.dart';

//* --> Dependencies.
/// [Router] manager instance.
final Router _router = Router.i;

/// Base for [CSMRouterTree].
///
/// Defines base behavior for [CSMRouterTree] implementations.
///
/// [CSMRouterTree] concept: defines the [RouterTreeB] configured to the [CSMApplication].
/// indicating all [Routing] configurations, behaviors and route nodes calculations along [CSMRouteNode]'s,
/// [CMSRouteLayout]'s and [CMSRouteWhisper] implementations, and all custom implementations based on their [Bases].
abstract class RouterTreeB extends GoRouter {
  /// Default [NavigationState] instance to use if the main application doesn't provide one.
  static final NavigationState _kNavigation = NavigationState();

  /// Stores a flag to indicate if the [CSMRouter]´s been already initd.
  static bool _routerOn = false;

  /// Stores the current path resolved.
  static String _currentPath = "";

  /// Creates a new [RouterTreeB] instance.
  RouterTreeB({
    Route? devRoute,
    required List<RouteB> routes,
    Redirection? redirect,
    GlobalKey<NavigatorState>? navigator,
  }) : super.routingConfig(
          navigatorKey: navigator ?? _kNavigation,
          routingConfig: _RouterListener(
            RoutingConfig(
              routes: <RouteBase>[
                for (RouteB routeBase in routes) routeBase.compose(),
              ],
              redirect: (BuildContext context, GoRouterState state) async {
                // --> Driver init
                if (!_routerOn) {
                  Router.initRouterTree(routes);
                  Router.initNavigator(navigator ?? _kNavigation);
                  _routerOn = true;
                }

                // --> Evaluating dev route redirect.
                if (devRoute != null && state.fullPath != null) {
                  String? devRedirect = _router.resolveDevelopment(devRoute, _currentPath, state.fullPath);
                  if (devRedirect != null) {
                    _currentPath = devRedirect;
                    return devRedirect;
                  }
                }
                if (redirect == null) return null;

                // --> Evaluate custom redirect injection.
                final String? targetPath = state.fullPath;
                if (targetPath == null) return null;
                final Route targetOptions = _router.getRoute(targetPath);
                final RouteData output = RouteData.fromGo(state, targetOptions);
                final Route? redirector = await redirect.call(context, output);
                if (redirector == null) return null;
                String? calculatedTargetPath = _router.getAbsolutePath(redirector);
                _currentPath = calculatedTargetPath;
                return calculatedTargetPath;
              },
            ),
          ),
        );
}
