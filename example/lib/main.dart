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

final class ExampleApplication extends StatelessWidget {
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
        ThemeManagerI<EXThemeBase> themeManager = GetIt.I.get<ThemeManagerI<EXThemeBase>>();

        EXThemeBase theme = themeManager.get();

        return Scaffold(
          backgroundColor: theme.backgroundColor,
          body: Column(
            children: [
              Switch(
                value: theme is EXThemeDark,
                onChanged: (value) {
                  themeManager.change(value ? const EXThemeDark().identifier : const EXThemeLigth().identifier);
                },
              ),
              const TestingEffect(),
            ],
          ),
        );
      },
    );
  }
}

class TestingEffect extends StatefulWidget {
  const TestingEffect({super.key});

  @override
  State<TestingEffect> createState() => _TestingEffectState();
}

final class _TestingEffectState extends State<TestingEffect> {
  late final UniqueKey effectKey = UniqueKey();
  late final ThemeManagerI<EXThemeBase> themeManager;

  late EXThemeBase theme;

  @override
  void initState() {
    super.initState();
    themeManager = GetIt.I.get<ThemeManagerI<EXThemeBase>>();

    theme = themeManager.addEffect(
      effectKey,
      (EXThemeBase theme) {
        setState(() {
          this.theme = theme;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 200,
      color: Colors.red,
      child: Center(
        child: Container(
          width: 50,
          height: 50,
          color: theme.backgroundColor,
        ),
      ),
    );
  }
}
