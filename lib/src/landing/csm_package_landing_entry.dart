import 'package:flutter/material.dart';

/// Stores the configuration of a CSMPackageLanding entry, meaning this will configure how the
/// button and the component will be displayed in the package landing application.
final class CSMPackageLandingEntry {
  /// The name of the component.
  final String name;

  /// The component description.
  final RichText description;

  /// Composition widget function, how will be drawn teh component in the landing application.
  ///
  /// [ctx] the parent build context.
  final Widget Function(BuildContext ctx) composeLanding;

  /// Creates a new [CSMPackageLandingEntry] object indicating how to draw and handle a new component entry
  /// at the Package Landing application.
  const CSMPackageLandingEntry({
    required this.name,
    required this.description,
    required this.composeLanding,
  });
}
