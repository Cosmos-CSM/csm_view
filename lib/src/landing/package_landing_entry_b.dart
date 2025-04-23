import 'package:csm_view/csm_view.dart';
import 'package:csm_view/src/utils/theming.dart';
import 'package:flutter/material.dart';

/// [abstract] class for [PackageLandingEntryB].
///
///
/// Defines and handles base behavior for [PackageLandingEntryB] implementations, wich are complex [PackageLanding] view entries
/// to be routed and displayed correctly as a package development helping.
abstract class PackageLandingEntryB<TThemeB extends PackageLandingThemeB> extends PageB implements PackageLandingEntryI<TThemeB> {
  /// The name of the landing entry.
  @override
  final String name;

  /// The landing entry description.
  @override
  final RichText description;

  /// Creates a new [PackageLandingEntryB]
  const PackageLandingEntryB({
    super.key,
    required this.name,
    required this.description,
  });

  @override
  Widget compose(BuildContext buildContext, Size windowSize) {
    final TThemeB theme = Theming.get<TThemeB>();

    return composeEntry(buildContext, windowSize, theme);
  }
}
