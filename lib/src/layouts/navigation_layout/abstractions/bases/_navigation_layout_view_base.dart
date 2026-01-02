part of '../../navigation_layout.dart';

/// Represents a navigation view.
abstract class _NavigationLayoutViewBase extends StatelessWidget implements INavigationLayout {
  /// Current wrapped page view.
  final Widget page;

  /// Current page box size space.
  final Size pageSize;

  /// Current routing data.
  final RoutingData routingData;

  /// Header application logo.
  @override
  final ImageProvider? appLogo;

  /// Layout home route.
  @override
  final RouteData? homeRouteData;

  /// Layout displayed user data.
  @override
  final INavigationLayoutHeaderUserData? userData;

  /// Layout nodes.
  @override
  final List<INavigationLayoutNode> navigationNodes;

  /// Solution specific user information builder to get and calculate user information to display at header user button.
  @override
  final INavigationLayoutHeaderUserData? Function()? userDataBuilder;

  /// Creates a new instance.
  const _NavigationLayoutViewBase({
    this.appLogo,
    this.userData,
    this.homeRouteData,
    this.userDataBuilder,
    required this.page,
    required this.pageSize,
    required this.routingData,
    required this.navigationNodes,
  });
}
