part of '../../navigation_layout.dart';

///
abstract class _NavigationLayoutBase extends StatelessWidget {
  ///
  final Widget page;

  ///
  final Size pageSize;

  ///
  final RouteData? rootRoute;

  ///
  final RouteData routeData;

  ///
  final INavigationLayoutHeaderUserData? user;

  ///
  final List<INavigationLayoutNode> navigationEntries;

  ///
  const _NavigationLayoutBase({
    this.user,
    this.rootRoute,
    required this.page,
    required this.pageSize,
    required this.routeData,
    required this.navigationEntries,
  });
}
