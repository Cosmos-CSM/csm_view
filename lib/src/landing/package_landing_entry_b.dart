import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart';

/// [abstract] class for [PackageLandingEntryB].
///
///
/// Defines and handles base behavior for [PackageLandingEntryB] implementations, wich are complex [PackagePlayground] view entries
/// to be routed and displayed correctly as a package development helping.
abstract class PackageLandingEntryB extends PageB implements PackageLandingEntryI {
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
}
