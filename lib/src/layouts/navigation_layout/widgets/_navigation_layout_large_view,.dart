part of '../navigation_layout.dart';

/// Draws the [NavigationLayout] on large devices view.
final class _NavigationLayoutLargeView extends _NavigationLayoutViewBase with ThemingMixin {
  /// Creates a new instance.
  _NavigationLayoutLargeView({
    super.appLogo,
    super.userData,
    super.homeRouteData,
    super.userDataBuilder,
    required super.page,
    required super.pageSize,
    required super.routingData,
    required super.navigationNodes,
  });

  @override
  Widget build(BuildContext context) {
    final _NavigationLayoutMenuReactor navReactor = _NavigationLayoutMenuReactor();

    return Row(
      children: <Widget>[
        Expanded(
          child: Column(
            children: <Widget>[
              _NavigationLayoutHeader(
                logo: appLogo,
                user: userData,
                navReactor: navReactor,
                routeData: homeRouteData,
              ),
              Expanded(
                child: ReactiveWidget<_NavigationLayoutMenuReactor>(
                  reactor: navReactor,
                  builder: (BuildContext buildContext, _NavigationLayoutMenuReactor reactor) {
                    const double menuWidth = 250;
                    final double currMenuWidth = reactor._isOpen ? menuWidth : 0;
                    final ThemingData pageTheme = getTheme<IThemeData>(context).page;

                    return Stack(
                      children: <Widget>[
                        // --> Page section
                        Align(
                          alignment: Alignment.centerRight,
                          child: AnimatedSize(
                            duration: 200.miliseconds,
                            child: SizedBox(
                              width: pageSize.width - currMenuWidth,
                              child: page,
                            ),
                          ),
                        ),

                        // --> Application menu section
                        AnimatedPositioned(
                          duration: 200.miliseconds,
                          left: reactor._isOpen ? 0 : -menuWidth,
                          width: menuWidth,
                          child: ColoredBox(
                            color: pageTheme.accent,
                            child: SizedBox(
                              width: menuWidth,
                              height: pageSize.height,
                              child: _NavigationLayoutMenu(
                                navigationNodes: navigationNodes,
                                routeData: routingData.targetRoute,
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
