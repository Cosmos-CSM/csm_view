import 'package:csm_view/csm_view.dart';
import 'package:example/core/theme/ex_them_dark.dart';
import 'package:example/core/theme/ex_theme_base.dart';
import 'package:example/core/theme/ex_theme_ligth.dart';
import 'package:flutter/material.dart';

void main(List<String> args) {
  runApp(
    const ExampleApplication(),
  );
}

class ExampleApplication extends StatelessWidget {
  const ExampleApplication({super.key});

  @override
  Widget build(BuildContext context) {
    return CSMApplication<EXThemeBase>(
      defaultTheme: const EXThemeLigth(),
      themes: const [
        EXThemeLigth(),
        EXThemeDark(),
      ],
      builder: (context, app) {
        EXThemeBase theme = getTheme();

        return Scaffold(
          backgroundColor: theme.backgroundColor,
          body: Column(
            children: [
              Switch(
                value: theme is EXThemeDark,
                onChanged: (value) {
                  updateTheme(theme is EXThemeDark ? const EXThemeLigth().identifier : const EXThemeDark().identifier);
                },
              )
            ],
          ),
        );
      },
    );
  }
}
