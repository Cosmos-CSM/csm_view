import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart';

/// {LayoutNode} class.
///
/// Implements a [RouteLayout] node to simplify the routing tree subscription for [NavigationLayout] configurations.
final class NavigationRoutingGraphLayout extends RoutingGraphLayoutBase {
  /// Home [Route] used to draw a direction header button to access it easier.
  final RouteData? rootRoute;

  /// Solution specific user information builder to get and calculate user information to display at header user button.
  final INavigationLayoutHeaderUserData? Function()? userBuilder;

  /// The navigation entries to be handled, drawing navigation buttons and the routing behavior.
  final List<INavigationLayoutNode> navigationEntries;

  /// Creates a new [NavigationRoutingGraphLayout] instance.
  NavigationRoutingGraphLayout({
    this.rootRoute,
    this.userBuilder,
    required super.routes,
    this.navigationEntries = const <INavigationLayoutNode>[],
  }) : super(
          layoutBuilder: (BuildContext _, RoutingData routingData, Widget page) {
            return NavigationLayout(
              page: page,
              rootRoute: rootRoute,
              userData: userBuilder?.call(),
              routingData: routingData,
              navigationEntries: navigationEntries,
            );
          },
        );
}
