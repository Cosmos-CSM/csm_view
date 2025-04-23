
import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart' hide Router, Route, LayoutBuilder;
import 'package:go_router/go_router.dart' hide RouteData;

/// [CSMRouter] dependency gather (for application routing purposes).
final Router _router = Router.i;

/// Base for [RouteLayout].
///
/// Provides specific handlers and properties to indicate the base neccesary functions for a
/// [RouteLayout] concept behavior.
/// A [RouteLayout] is as well known at development as a UI wrapper for its children routes,
/// creating a standarized UI that'll be always consistent routing allong all Layout's children routes.
class RouteLayoutB extends RouteB implements RouteLayoutI {
  /// Identifier to the restoration scope along [Router]´s implementation restoration manager.
  @override
  final String? restoration;

  /// Observers for a [RouteLayout]. Used to subscribe custom observers at the [Routing] native framwork.
  @override
  final List<NavigatorObserver>? observers;

  /// Custom [Navigation]. To handle operations along its children routes.
  @override
  final NavigationState? navigatorStateKey;

  /// Handles the build for a dynamic transition at the routing event.
  @override
  final Page<dynamic> Function(LayoutI layout)? transitionBuild;

  /// When the client enters into this route, will be redirected to this resolved redirect function.
  @override
  final Redirection? redirection;

  /// Build function to create the [Layout] UI and draw it in the screen.
  @override
  final LayoutBuilder layoutBuilder;

  /// A complex Route object to indicate the existance of a route nodes wrapper into the Route manager.
  /// This means that this object only creates the clnfiguration for handle the redirection/direction of
  /// a complex [CSMLayoutBase] with its calculated [CSMPage] routed.
  const RouteLayoutB({
    super.parentNavigatorStateKey,
    this.restoration,
    this.navigatorStateKey,
    this.observers,
    this.transitionBuild,
    this.redirection,
    required super.routes,
    required this.layoutBuilder,
  });

  @override
  RouteBase compose({
    bool isSub = false,
    Redirection? redirection,
  }) {
    return ShellRoute(
      observers: observers,
      navigatorKey: navigatorStateKey,
      parentNavigatorKey: parentNavigatorStateKey,
      restorationScopeId: restoration ?? GlobalKey().toString(),
      pageBuilder: (BuildContext context, GoRouterState state, Widget child) {
        String path = state.uri.toString();
        Route route = _router.getRoute(path);
        LayoutI layoutLaid = layoutBuilder(context, RouteData.fromGo(state, route), child);
        return transitionBuild?.call(layoutLaid) ?? noTransition(layoutLaid);
      },
      routes: <RouteBase>[
        for (RouteB route in routes)
          route.compose(
            isSub: isSub,
            redirection: redirection,
          ),
      ],
    );
  }
}
