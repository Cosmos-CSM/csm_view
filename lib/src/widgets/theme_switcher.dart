import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart';

///
final class ThemeSwitcher extends StatelessWidget {
  ///
  final List<ThemeI> applicationThemes;

  const ThemeSwitcher({
    super.key,
    required this.applicationThemes,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeManagerI<ThemeI> themeManager = Injector.getThemeManager();
    final ThemeI theme = themeManager.get();

    return Visibility(
      visible: applicationThemes.length > 1,
      replacement: SizedBox(),
      child: Visibility(
        visible: applicationThemes.length == 2,
        replacement: ErrorWidget(
          'Not Implemented View For More Than 2 Themes Switching',
        ),
        child: Material(
          color: Colors.transparent,
          child: Switch(
            value: theme.identifier == applicationThemes[0].identifier,
            activeColor: Colors.white,
            trackColor: WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
              if (states.contains(WidgetState.selected)) {
                return applicationThemes[0].iconBackground;
              }

              return applicationThemes[1].iconBackground;
            }),
            thumbIcon: WidgetStateProperty.resolveWith<Icon>(
              (Set<WidgetState> states) {
                if (states.contains(WidgetState.selected)) {
                  return applicationThemes[0].icon;
                }

                return applicationThemes[1].icon;
              },
            ),
            onChanged: (bool value) {
              themeManager.change(value ? applicationThemes[0].identifier : applicationThemes[1].identifier);
            },
          ),
        ),
      ),
    );
  }
}
