import 'package:csm_view/csm_view.dart' hide LayoutBuilder;
import 'package:flutter/material.dart' hide Router, Route;

export './abstractions/bases/navigation_layout_node_base.dart';
export './abstractions/interfaces/inavigation_layout.dart';
export './abstractions/interfaces/inavigation_layout_header_user_data.dart';
export './abstractions/interfaces/inavigation_layout_node.dart';
export './abstractions/interfaces/inavigation_layout_theme_data.dart';
export './navigation_layout_node.dart';
export './navigation_layout_routing_graph_data.dart';

part '_navigation_layout_menu_reactor.dart';
part 'abstractions/bases/_navigation_layout_view_base.dart';
part 'widgets/_navigation_layout_,menu_button.dart';
part 'widgets/_navigation_layout_header.dart';
part 'widgets/_navigation_layout_header_user_button.dart';
part 'widgets/_navigation_layout_header_user_button_menu.dart';
part 'widgets/_navigation_layout_large_view,.dart';
part 'widgets/_navigation_layout_menu.dart';
part 'widgets/_navigation_layout_small_view.dart';

/// Draws a complex { View } navigation layout that handles main application sections navigation, theming management and user data / management access.
final class NavigationLayout extends ViewLayoutBase implements INavigationLayout {
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
  const NavigationLayout({
    this.appLogo,
    this.userData,
    this.homeRouteData,
    this.userDataBuilder,
    required super.page,
    required super.routingData,
    this.navigationNodes = const <INavigationLayoutNode>[],
  });

  ///
  @override
  Widget compose(BuildContext buildContext, Size windowSize, Size pageSize) {
    final INavigationLayoutHeaderUserData? userData = this.userData ?? userDataBuilder?.call();

    return ResponsiveWidget(
      onLarge: _NavigationLayoutLargeView(
        page: page,
        appLogo: appLogo,
        userData: userData,
        pageSize: pageSize,
        routingData: routingData,
        homeRouteData: homeRouteData,
        navigationNodes: navigationNodes,
        userDataBuilder: userDataBuilder,
      ),
      onSmall: _NavigationLayoutSmallView(
        page: page,
        pageSize: pageSize,
        userData: userData,
        routingData: routingData,
        navigationNodes: navigationNodes,
      ),
    );
  }
}
