import 'package:csm_view/csm_view.dart';
import 'package:example/entries/theme_manager.dart';
import 'package:flutter/material.dart';

void main(List<String> args) {
  runApp(
    PackageLanding(
      title: 'CSM View',
      entries: [
        PackageLandingEntry(
          name: 'Theming Management',
          description: RichText(
            text: const TextSpan(
              text: '',
            ),
          ), 
          composer: (BuildContext context) => const Theming(),
        ),
      ],
    ),
  );
}
