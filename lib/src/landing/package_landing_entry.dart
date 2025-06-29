import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart';


/// {interface} class.
///
///
/// [T] type of the [ThemeDataB] application theme base implementation.
///
/// Defines contract for [PackageLandingEntryI] implementations wich means is a correct entry for the [PackagageLanding]
/// handler to draw and route correctly it.
abstract interface class PackageLandingEntryI<T extends LandingThemeB> implements PageI {
  /// The name of the component.
  final String name;

  /// Image to represent the package at the [Welcome] page cards.
  final ImageProvider? image;

  /// The component description.
  final DescriptionBuilder<T> description;

  /// Creates a new [PackageLandingEntryI] instance.
  const PackageLandingEntryI({
    this.image,
    required this.name,
    required this.description,
  });

  /// Composes nested [RouteB] implementations when the {entry} inner component needs to access a navigation route by its own behavior.
  List<RouteB> composeRoutes(GlobalKey<NavigatorState> navigationLayoutKey, GlobalKey<NavigatorState> entryLayoutKey) =>
      <RouteB>[];

  /// Custom composition method for [PackageLandingEntryI] implementations to bypass [PageI], [compose].
  Widget composeEntry(BuildContext buildContext, Size windowSize, T theme);
}

/// {abstract} class.
///
///
/// [T] type of the [ThemeDataB] application base theming implementation.
///
/// Defines and handles base behavior for [PackageLandingEntryB] implementations, wich are complex [PackageLanding] view entries
/// to be routed and displayed correctly as a package development helping.
abstract class PackageLandingEntryB<T extends LandingThemeB> extends PageB implements PackageLandingEntryI<T> {
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
  List<RouteB> composeRoutes(GlobalKey<NavigatorState> navigationLayoutKey, GlobalKey<NavigatorState> entryLayoutKey) =>
      <RouteB>[];

  @override
  Widget compose(BuildContext buildContext, Size windowSize, Size pageSize) {
    final T theme = Theming.get<T>(buildContext);

    return composeEntry(buildContext, windowSize, theme);
  }
}

/// Stores the configuration of a CSMPackageLanding entry, meaning this will configure how the
/// button and the component will be displayed in the package landing application.
final class PackageLandingEntry<TThemeB extends LandingThemeB> extends PackageLandingEntryB<TThemeB> {
  /// Composition widget function, how will be drawn teh component in the landing application.
  ///
  /// [ctx] the parent build context.
  ///
  /// [windowSize] computed current window size.
  final Widget Function(BuildContext buildContext, Size windowSize, TThemeB theme) contentBuilder;

  /// Creates a new [PackageLandingEntry] object indicating how to draw and handle a new component entry
  /// at the Package Landing application.
  const PackageLandingEntry({
    super.key,
    super.image,
    required super.name,
    required super.description,
    required this.contentBuilder,
  });

  @override
  Widget composeEntry(BuildContext buildContext, Size windowSize, TThemeB theme) {
    return contentBuilder(buildContext, windowSize, theme);
  }
}
