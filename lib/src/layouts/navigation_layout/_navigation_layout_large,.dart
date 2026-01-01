part of 'navigation_layout.dart';

/// {widget} class.
///
/// Draws the [NavigationLayout] when the device is large.
final class _NavigationLayoutLarge extends _NavigationLayoutBase with ThemingMixin {
  const _NavigationLayoutLarge({
    super.rootRoute,
    required super.page,
    required super.user,
    required super.pageSize,
    required super.routeData,
    required super.navigationEntries,
  });

  @override
  Widget build(BuildContext context) {
    final _NavigationLayourNavigationReactor navReactor = _NavigationLayourNavigationReactor();

    return Row(
      children: <Widget>[
        Expanded(
          child: Column(
            children: <Widget>[
              _NavigationLayoutHeader(
                user: user,
                rootRoute: rootRoute,
                navReactor: navReactor,
              ),
              Expanded(
                child: ReactiveWidget<_NavigationLayourNavigationReactor>(
                  reactor: navReactor,
                  builder: (BuildContext buildContext, _NavigationLayourNavigationReactor reactor) {
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
                              child: _NavigationLayoutNavigation(
                                currentRoute: routeData,
                                navigationEntries: navigationEntries,
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
