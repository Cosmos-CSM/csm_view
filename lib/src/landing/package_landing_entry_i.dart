import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart' show BuildContext, ImageProvider, Size, Widget;

/// [interface] for [PackageLandingEntryI].
///
/// 
/// [T] type of the [ThemeB] application theme base implementation.
///
/// Defines contract for [PackageLandingEntryI] implementations wich means is a correct entry for the [PackagageLanding]
/// handler to draw and route correctly it.
abstract interface class PackageLandingEntryI<T extends PackageLandingThemeB> implements PageI {
  /// The name of the component.
  final String name;

  /// Image to represent the package at the [Welcome] page cards.
  final ImageProvider? image;

  /// The component description.
  final DescriptionBuilder<T> description;

  /// Custom composition method for [PackageLandingEntryI] implementations to bypass [PageI], [compose].
  Widget composeEntry(BuildContext buildContext, Size windowSize, T theme);

  /// Creates a new [PackageLandingEntryI] instance.
  const PackageLandingEntryI({
    this.image,
    required this.name,
    required this.description,
  });
}
