import 'package:csm_view/csm_view.dart';
import 'package:example/entries/whisper_entry.dart';
import 'package:example/theme/csm_view_theme_b.dart';
import 'package:example/theme/csm_view_theme_dark.dart';
import 'package:example/theme/csm_view_theme_light.dart';
import 'package:flutter/material.dart';


void main(List<String> args) {

  runApp(
    PackageLanding<CSMViewThemeB>(
      name: 'CSM View',
      description: (_, Color foreColor) {
        return TextSpan(
          text: 'This package provides a wide collection of utilities to handle basic view solutions to enhance customer experience and development experiment.',
          style: TextStyle(
            color: foreColor,
            fontSize: 16,
          ),
        );
      },
      defaultTheme: CSMViewThemeLight(),
      themes: <CSMViewThemeB>[
        CSMViewThemeDark(),
      ],
      landingEntries: <PackageLandingEntryI<CSMViewThemeB>>[
        WhisperEntry()
      ],
    ),
  );
}
