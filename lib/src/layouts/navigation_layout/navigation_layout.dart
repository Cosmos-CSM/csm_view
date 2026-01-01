import 'package:csm_view/csm_view.dart' hide LayoutBuilder;
import 'package:csm_view/src/theming/abstractions/interfaces/inavigation_layout_theme_data.dart';
import 'package:flutter/material.dart' hide Router, Route;

part 'abstractions/bases/_navigation_layout_base.dart';
part '_navigation_layout_header/_navigation_layout_header.dart';
part '_navigation_layout_header/_navigation_layout_header_user_button.dart';
part '_navigation_layout_header/_navigation_layout_header_user_button_menu.dart';
part '_navigation_layout_large,.dart';
part '_navigation_layout_navigation/_navigation_layout_navigation.dart';
part '_navigation_layout_navigation/_navigation_layout_navigation_reactor.dart';
part '_navigation_layout_small.dart';

///
final class NavigationLayout extends ViewLayoutBase {
  ///
  final RouteData? rootRoute;

  ///
  final INavigationLayoutHeaderUserData? userData;

  final List<INavigationLayoutNode> navigationEntries;

  ///
  const NavigationLayout({
    this.userData,
    this.rootRoute,
    required super.page,
    required super.routingData,
    this.navigationEntries = const <INavigationLayoutNode>[],
  });

  ///
  @override
  Widget compose(BuildContext buildContext, Size windowSize, Size pageSize) {
    return ResponsiveWidget(
      onLarge: _NavigationLayoutLarge(
        page: page,
        user: userData,
        pageSize: pageSize,
        rootRoute: rootRoute,
        routeData: routingData.targetRoute,
        navigationEntries: navigationEntries,
      ),
      onSmall: _MasterLayoutSmall(
        user: userData,
        page: page,
        pageSize: pageSize,
        routeData: routingData.targetRoute,
        navigationEntries: navigationEntries,
      ),
    );
  }
}
