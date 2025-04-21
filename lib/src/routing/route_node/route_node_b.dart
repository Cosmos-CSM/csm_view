import 'dart:async';
import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart' hide Router, Route;
import 'package:go_router/go_router.dart' hide RouteData;

/// [Router] dependency.
final Router _router = Router.i;

/// [abstract] class for [RouteNodeB].
///
/// Defines and handles behavior for a [RouteNodeB] implementation wich is a [Router] calculation node determining it as a final visible
/// route path to be renderized and interactable.
abstract class RouteNodeB extends RouteB implements RouteNodeI {
  /// Route information.
  @override
  final Route route;

  /// Builder function to build and renderize [PageI] into the interactable [Widget] tree.
  @override
  final PageBuilder pageBuilder;

  /// When the client enters into this route, will be redirected to this resolved [Redirection] function.
  @override
  final Redirection? redirection;

  /// Builder for [PageI] transitions along [Router] events.
  @override
  final Page<void> Function(PageI page)? transitionBuilder;

  /// Callback invoked when the current [route] is popped or removed from the [Router] history.
  /// (.go() can remove it from the history too.)
  @override
  final FutureOr<bool> Function(BuildContext ctx, RouteData routeData)? onDispose;

  /// Creates a new [RouteNodeB] instance.
  const RouteNodeB(
    this.route, {
    required this.pageBuilder,
    super.parentNavigatorStateKey,
    super.routes,
    this.redirection,
    this.transitionBuilder,
    this.onDispose,
  });

  @override
  RouteBase compose({
    bool isSub = false,
    Redirection? redirection,
  }) {
    return GoRoute(
      path: resolvePath(isSub),
      name: route.name,
      parentNavigatorKey: parentNavigatorStateKey,
      onExit: onDispose == null
          ? null
          : (BuildContext context, GoRouterState state) => onDispose!.call(
                context,
                RouteData.fromGo(state, route),
              ),
      redirect: (BuildContext ctx, GoRouterState state) async {
        if (_router.devRedirectNode()) {
          return null;
        }

        RouteData output = RouteData.fromGo(state, route);
        FutureOr<Route?>? resultOptions;
        resultOptions = redirection?.call(ctx, output) ?? redirection?.call(ctx, output);
        Route? calcualtedRedirectionResult = await resultOptions;
        if (calcualtedRedirectionResult == null) return null;
        String? absolutePath = _router.getAbsolutePath(calcualtedRedirectionResult);
        return absolutePath;
      },
      routes: <RouteBase>[
        for (RouteB cr in routes) cr.compose(isSub: true),
      ],
      pageBuilder: (BuildContext context, GoRouterState state) {
        RouteData routeOutput = RouteData.fromGo(state, route);
        CSMPageBase pageLaid = pageBuilder(context, routeOutput);

        return transitionBuilder?.call(pageLaid) ?? noTransition(pageLaid);
      },
    );
  }

  /// Calculates the node path based on the parse if it has parent nodes.
  ///
  /// [isSub] Wheter the current node has a parent node.
  @override
  String resolvePath([bool isSub = false]) {
    String parsedPath = route.path;
    if (parsedPath.startsWith('/') && isSub) {
      parsedPath = parsedPath.substring(1, parsedPath.length);
    }

    return parsedPath;
  }
}
