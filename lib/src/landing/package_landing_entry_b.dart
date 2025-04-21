import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart';

/// [abstract] class for [PackageLandingEntryB].
///
///
/// Defines and handles base behavior for [PackageLandingEntryB] implementations, wich are complex [PackageLanding] view entries
/// to be routed and displayed correctly as a package development helping.
abstract class PackageLandingEntryB extends StatelessWidget implements PackageLandingEntryI {
  /// Creates a new [PackageLandingEntryB]
  const PackageLandingEntryB({super.key});

  @override
  Widget build(BuildContext context) {
    return compose(context);
  }
}
