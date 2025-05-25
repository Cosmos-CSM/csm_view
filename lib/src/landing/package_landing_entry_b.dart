import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart';

/// [abstract] class for [PackageLandingEntryB].
///
/// 
/// [T] type of the [ThemeB] application base theming implementation.
///
/// Defines and handles base behavior for [PackageLandingEntryB] implementations, wich are complex [PackageLanding] view entries
/// to be routed and displayed correctly as a package development helping.
abstract class PackageLandingEntryB<T extends PackageLandingThemeB> extends PageB implements PackageLandingEntryI<T> {
  /// The name of the landing entry.
  @override
  final String name;

  
  /// Image to represent the package at the [Welcome] page cards.
  @override
  final ImageProvider? image;

  /// The landing entry description.
  @override
  final DescriptionBuilder<T> description;

  /// Creates a new [PackageLandingEntryB]
  const PackageLandingEntryB({
    super.key,
    this.image,
    required this.name,
    required this.description,
  });

  @override
  Widget compose(BuildContext buildContext, Size windowSize, Size pageSize) {
    final T theme = Theming.get<T>();

    return composeEntry(buildContext, windowSize, theme);
  }
}
