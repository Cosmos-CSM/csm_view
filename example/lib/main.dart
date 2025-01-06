import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart';

void main(List<String> args) {
  runApp(
    CSMPackageLanding(
      title: 'CSM View',
      landingEntry: CSMPackageLandingEntry(
        name: 'Testing Component',
        description: RichText(
          text: const TextSpan(
            text: 'A testing description to show how the description is being displayed in the landing playground',
          ),
        ),
        composeLanding: (ctx) {
          return Container(
            color: Colors.orange,
          );
        },
      ),
      entries: const [],
    ),
  );
}
