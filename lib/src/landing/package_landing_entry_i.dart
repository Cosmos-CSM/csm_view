import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart' show RichText;

/// [interface] for [PackageLandingEntryI].
///
///
/// Defines contract for [PackageLandingEntryI] implementations wich means is a correct entry for the [PackagageLanding]
/// handler to draw and route correctly it.
abstract interface class PackageLandingEntryI implements PageI {
  /// The name of the component.
  final String name;

  /// The component description.
  final RichText description;

  /// Creates a new [PackageLandingEntryI] instance.
  const PackageLandingEntryI({
    required this.name,
    required this.description,
  });
}
