import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart';

/// Stores the configuration of a CSMPackageLanding entry, meaning this will configure how the
/// button and the component will be displayed in the package landing application.
final class PackageLandingEntry extends PackageLandingEntryB {

  /// Composition widget function, how will be drawn teh component in the landing application.
  ///
  /// [ctx] the parent build context.
  /// 
  /// [windowSize] computed current window size.
  final Widget Function(BuildContext ctx, Size windowSize) contentBuilder;

  /// Creates a new [PackageLandingEntry] object indicating how to draw and handle a new component entry
  /// at the Package Landing application.
  const PackageLandingEntry({
    super.key, 
    required super.name,
    required super.description,
    required this.contentBuilder,
  });
  
  @override
  Widget compose(BuildContext ctx, Size window) {
    return contentBuilder(ctx, window);
  }
}
