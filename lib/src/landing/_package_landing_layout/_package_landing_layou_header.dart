part of '../package_landing.dart';

/// [Widget] implementation for [_PackageLandingLayout].
/// 
/// 
/// Draws a view for the [_PackageLandingLayout] header.
final class _PackageLandingLayouHeader extends StatelessWidget {

  /// The current routed [PackageLandingEntry] displayed.
  final String entryTitle;

  /// The [List] of available subscribed application themes implementations.
  final List<ThemeI> applicationThemes;

  /// [ReactorI] handler for the application menu, this allows to open or close it dinamycally as it's state.
  final _ApplicationMenuReactor menuReactor;

  /// Createsa a new [_PackageLandingLayouHeader] instance. 
  const _PackageLandingLayouHeader({
    required this.entryTitle,
    required this.menuReactor,
    required this.applicationThemes,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeManagerI<PackageLandingThemeB> themeManager = Injector.getThemeManager();
    final PackageLandingThemeB theme = themeManager.get();

    final Router router = Router.i;

    return ColoredBox(
      color: theme.headerTheming.back,
      child: SizedBox(
        width: double.maxFinite,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 4,
            horizontal: 12,
          ),
          child: Wrap(
            spacing: 12,
            runSpacing: 12,
            alignment: WrapAlignment.spaceBetween,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: <Widget>[
              Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  IconButton(
                    onPressed: () {
                      menuReactor.toogle();
                    },
                    icon: Icon(
                      Icons.menu,
                      color: theme.headerTheming.accent,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: 20,
                    ),
                    child: Text(
                      entryTitle,
                      style: TextStyle(
                        fontSize: 16,
                        color: theme.headerTheming.fore,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  IconButton(
                    icon: Icon(
                      Icons.home,
                      color: theme.headerTheming.accent,
                    ),
                    onPressed: () {
                      router.go(_homeRoute);
                    },
                  ),
                  ThemeSwitcher(
                    applicationThemes: applicationThemes,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
