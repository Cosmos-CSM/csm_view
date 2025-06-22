part of '../package_landing.dart';



final class _ApplicationMenuReactor extends ReactorB {
  /// Reactor context reference for the context;
  bool _isOpen = true;

  /// Toogles the application menu reverting their current state.
  ///
  ///
  /// [forceState] if this is provided then will force the inner state without toogling the current value.
  void toogle([bool? forceState]) {
    if (forceState != null) {
      _isOpen = forceState;
    } else {
      _isOpen = !_isOpen;
    }

    react();
  }
}

final _ApplicationMenuReactor _menuReactor = _ApplicationMenuReactor();

/// [LayoutB] implementation for a [PackageLanding].
///
///
/// This layout draws the navigation view through the package configured entries.
final class _PackageLandingLayout<T extends PackageLandingThemeB> extends LayoutB {
  final Map<Route, PackageLandingEntryI<T>> routingTree;

  /// The current configured application themes implementations.
  final List<ThemeI> themes;

  /// Creates a new [_PackageLandingLayout] instance.
  const _PackageLandingLayout({
    required super.page,
    required super.routeData,
    
    required this.themes,
    required this.routingTree,
  });

  @override
  Widget compose(BuildContext buildContext, Size windowSize, Size pageSize) {
    final PackageLandingThemeB theme = Theming.get();

    return Title(
      title: routeData.route.name,
      color: Colors.black,
      child: Column(
        children: <Widget>[
          _PackageLandingLayouHeader(
            entryTitle: routeData.route.name,
            applicationThemes: themes,
            menuReactor: _menuReactor,
          ),
          Expanded(
            child: ReactiveWidget<_ApplicationMenuReactor>(
              reactor: _menuReactor,
              builder: (BuildContext buildContext, _ApplicationMenuReactor reactor) {
                const double menuWidth = 250;
                final double currMenuWidth = reactor._isOpen ? menuWidth : 0;

                return Stack(
                  children: <Widget>[
                    // --> Page section
                    Align(
                      alignment: Alignment.centerRight,
                      child: SizedBox(
                        width: pageSize.width - currMenuWidth,
                        child: page,
                      ),
                    ),

                    // --> Application menu section
                    AnimatedPositioned(
                      duration: 200.miliseconds,
                      left: reactor._isOpen ? 0 : -menuWidth,
                      width: menuWidth,
                      child: ColoredBox(
                        color: theme.pageTheming.accent,
                        child: SizedBox(
                          width: menuWidth,
                          height: pageSize.height,
                          child: _PackageLandingLayoutMenu<T>(
                            menuWidth: menuWidth,
                            routingTree: routingTree,
                            currentRoute: routeData.route,
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
    );
  }
}
