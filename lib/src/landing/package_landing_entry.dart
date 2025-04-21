import 'package:csm_view/src/landing/package_landing_entry_b.dart';
import 'package:flutter/material.dart';

/// Stores the configuration of a CSMPackageLanding entry, meaning this will configure how the
/// button and the component will be displayed in the package landing application.
final class PackageLandingEntry extends PackageLandingEntryB {
  /// Entry title / name.
  @override
  final String name;

  /// Entry description.
  @override
  final RichText description;

  /// Composition widget function, how will be drawn teh component in the landing application.
  ///
  /// [ctx] the parent build context.
  final Widget Function(BuildContext ctx) composer;

  /// Creates a new [PackageLandingEntry] object indicating how to draw and handle a new component entry
  /// at the Package Landing application.
  const PackageLandingEntry({
    super.key, 
    required this.name,
    required this.description,
    required this.composer,
  });

  @override
  Widget compose(BuildContext context) {
    return composer(context);
  }
}
