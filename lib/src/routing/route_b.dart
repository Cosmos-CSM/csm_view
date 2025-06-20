import 'package:csm_view/csm_view.dart';
import 'package:flutter/widgets.dart' hide Router, Route;
import 'package:go_router/go_router.dart' hide RouteData;

/// [abstract] class for [RouteB].
///
/// Handles base behaviors for a [RouteB] implementation, which is a [Router] shared required behavior contract for each different type of [Router] tree entry.
abstract class RouteB implements RouteI {
  /// This is for a nested [Router]s implementation, when for some development needs there must be nested [Router]s, this stores the
  /// direct parent [NavigatorState] access key.
  @override
  final NavigationState? parentNavigatorStateKey;

  /// Routes below the current Route node.
  /// Note: this don't mean [subRoutes] will be wrapped by this route, this means
  /// that [routes] path will be calculated after this [CSMRouteOptions].
  @override
  final List<RouteB> routes;

  /// Generates an [RouteB] implementation.
  const RouteB({
    this.parentNavigatorStateKey,
    this.routes = const <RouteB>[],
  });

  /// Performs the composition from a [Route] to the native framework route handler [GoRouter].
  @override
  RouteBase compose({
    bool isSub = false,
    Redirection? redirection,
  });

  /// Performs the build for a [Page] for no transition route.
  @override
  CustomTransitionPage<T> noTransition<T>(Widget page) {
    return CustomTransitionPage<T>(
      child: page,
      transitionDuration: 0.seconds,
      reverseTransitionDuration: 0.seconds,
      transitionsBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
        return child;
      },
    );
  }
}
