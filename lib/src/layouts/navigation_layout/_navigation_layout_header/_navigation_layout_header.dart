part of '../navigation_layout.dart';

/// {widget} class.
///
/// Draws the [NavigationLayout] header.
final class _NavigationLayoutHeader extends StatelessWidget with ThemingMixin {
  /// Default root [Route], used to draw and handle a Home button that directs to this [Route].
  final RouteData? rootRoute;

  /// User information, used to draw an User Button to access information and options.
  final INavigationLayoutHeaderUserData? user;

  /// {internal} Reactor reference for [_NavigationLayoutNavigation] state.
  final _NavigationLayourNavigationReactor navReactor;

  /// Creates a new [_NavigationLayoutHeader] instance.
  const _NavigationLayoutHeader({
    this.user,
    this.rootRoute,
    required this.navReactor,
  });

  @override
  Widget build(BuildContext context) {
    final ThemingData theme = getTheme<INavigationLayoutThemeData>(context).navigationLayout;
    final Router router = InjectorUtils.get();

    return ColoredBox(
      color: theme.back,
      child: SizedBox(
        height: 50,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                      color: theme.fore,
                    ),
                  ),
                ),
              ),

              /// --> Navigation Header Theme Selection
              Row(
                children: <Widget>[
                  if (rootRoute != null)
                    IconButton(
                      icon: Icon(
                        Icons.home,
                        color: theme.fore,
                      ),
                      onPressed: () {
                        router.go(context, rootRoute!);
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
                      userData: user!,
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
