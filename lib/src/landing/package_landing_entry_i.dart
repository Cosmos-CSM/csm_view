import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart' show BuildContext, RichText, Widget;

/// [interface] for [PackageLandingEntryI].
///
///
/// Defines contract for [PackageLandingEntryI] implementations wich means is a correct entry for the [PackagageLanding]
/// handler to draw and route correctly it.
abstract interface class PackageLandingEntryI implements Widget {
  /// The name of the component.
  final String name;

  /// The component description.
  final RichText description;

  /// View composition builder.
  ///
  /// [context] current [Router] tree building context.
  Widget compose(BuildContext context);

  /// Creates a new [PackageLandingEntryI] instance.
  const PackageLandingEntryI({
    required this.name,
    required this.description,
  });
}
