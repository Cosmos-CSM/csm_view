part of '../package_landing.dart';

///
final class _PackageLandingLayouHeader extends StatelessWidget {
  final List<ThemeI> themes;

  ///
  const _PackageLandingLayouHeader({
    required this.themes,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeManagerI<PackageLandingThemeB> themeManager = Injector.getThemeManager();
    final PackageLandingThemeB theme = themeManager.get();

    return ColoredBox(
      color: theme.layoutHeaderColor,
      child: SizedBox(
        width: double.maxFinite,
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            ThemeSwitcher(
              applicationThemes: themes,
            ),
          ],
        ),
      ),
    );
  }
}
