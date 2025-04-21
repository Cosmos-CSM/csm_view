import 'dart:async';

import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart' hide Router, Route;
import 'package:go_router/go_router.dart' hide RouteData;

/// [interface] for [RouteI].
///
/// Defines specifications for a [RouteI] implementation, wich is a [Router] shared required behavior contract for each different type of [Router] tree entry.
abstract interface class RouteI {
  /// This is for a nested [Router]s implementation, when for some development needs there must be nested [Router]s, this stores the
  /// direct parent [NavigatorState] access key.
  final NavigationState? parentNavigatorStateKey;

  /// Nested [Route]s from this [Route] path.
  ///
  /// NOTE: this doesn't mean [routes] will be wrapped by this route, this means
  /// that [routes]'s paths will be calculated after this [Route].
  final List<RouteI> routes;

  const RouteI({
    this.parentNavigatorStateKey,
    this.routes = const <RouteI>[],
  });

  /// Performs the build for a [Page] for no transition route.
  CustomTransitionPage<T> noTransition<T>(Widget page);

  /// Performs the composition from a [Route] to the native framework route handler [GoRouter].
  RouteBase compose({
    bool isSub = false,
    FutureOr<Route?> Function(BuildContext ctx, RouteData routeData)? redirection,
  });
}
