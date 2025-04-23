import 'package:csm_view/csm_view.dart';
import 'package:example/theme/csm_view_theme_b.dart';
import 'package:example/theme/csm_view_theme_dark.dart';
import 'package:example/theme/csm_view_theme_light.dart';
import 'package:flutter/material.dart';

void main(List<String> args) {
  runApp(
    PackageLanding<CSMViewThemeB>(
      name: 'CSM View',
      defaultTheme: CSMViewThemeLight(),
      themes: <CSMViewThemeB>[
        CSMViewThemeDark(),
      ],
      landingEntries: <PackageLandingEntryI<CSMViewThemeB>>[
        PackageLandingEntry(
          name: 'Theming Behavior',
          description: RichText(
            text: const TextSpan(
                text: 'Some descriptive text'),
          ),
          contentBuilder: (BuildContext buildContext, Size windowSize, CSMViewThemeB theme) {
            return const Center(
              child: Text(
                'Welcome to your first entry!',
              ),
            );
          },
        ),
      ],
    ),
  );
}

