import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart';

void main(List<String> args) {
  runApp(
    PackagePlayground(
      name: 'CSM View',
      landingEntries: <PackageLandingEntryI>[
        PackageLandingEntry(
          name: 'Theming Behavior',
          description: RichText(
            text: const TextSpan(
                text: 'Some descriptive text'),
          ),
          contentBuilder: (ctx, windowSize) {
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

