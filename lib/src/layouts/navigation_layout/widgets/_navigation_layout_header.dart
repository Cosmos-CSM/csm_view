part of '../navigation_layout.dart';

/// Draws for [NavigationLayout] a header view that displays titles, handles theming and user data access.
final class _NavigationLayoutHeader extends StatelessWidget with ThemingMixin {
  /// Default root [Route], used to draw and handle a Home button that directs to this [Route].
  final RouteData? routeData;

  /// User information, used to draw an User Button to access information and options.
  final INavigationLayoutHeaderUserData? user;

  /// {internal} Reactor reference for [_NavigationLayoutMenu] state.
  final _NavigationLayoutMenuReactor navReactor;

  /// Header application logo.
  final ImageProvider? logo;

  /// Creates a new [_NavigationLayoutHeader] instance.
  const _NavigationLayoutHeader({
    this.logo,
    this.user,
    this.routeData,
    required this.navReactor,
  });

  @override
  Widget build(BuildContext context) {
    final ThemingData themeData = getTheme<INavigationLayoutThemeData>(context).navigationLayout;

    final IRouter router = InjectorUtils.get();

    return ColoredBox(
      color: themeData.back,
      child: SizedBox(
        height: 50,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              /// --> Header left section
              Row(
                spacing: 30,
                children: <Widget>[
                  /// --> Navigation Header Menu Drawer Toogle Button
                  Visibility(
                    visible: true,
                    child: MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        onTap: navReactor.toogle,
                        child: Icon(
                          Icons.menu,
                          color: themeData.fore,
                        ),
                      ),
                    ),
                  ),

                  /// --> App Logo
                  if (logo != null)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: FittedBox(
                        fit: BoxFit.fitHeight,
                        child: Image(image: logo!),
                      ),
                    )
                ],
              ),

              /// --> Navigation Header Theme Selection
              Row(
                children: <Widget>[
                  if (routeData != null)
                    IconButton(
                      icon: Icon(
                        Icons.home,
                        color: themeData.fore,
                      ),
                      onPressed: () {
                        router.go(context, routeData!);
                      },
                    ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 6,
                    ),
                    child: ThemeSwitcher(),
                  ),
                  if (user != null)
                    _NavigationHeaderUserButton(
                      user: user!,
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
