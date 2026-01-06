import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart';

/// {abstract} class.
///
///
/// [T] type of the [IThemeData] application base theming implementation.
///
/// Defines and handles base behavior for [PackageLandingEntryBase] implementations, wich are complex [PackageLanding] view entries
/// to be routed and displayed correctly as a package development helping.
abstract class PackageLandingEntryBase<T extends PackageLandingThemeBase> extends ViewPageBase implements IPackageLandingEntry<T> {
  /// The name of the landing entry.
  @override
  final String name;

  /// Image to represent the package at the [Welcome] page cards.
  @override
  final ImageProvider? image;

  /// The landing entry description.
  @override
  final DescriptionBuilder<T> description;

  /// Creates a new [PackageLandingEntryBase]
  const PackageLandingEntryBase({
    super.key,
    this.image,
    required this.name,
    required this.description,
  });

  @override
  List<IRoutingGraphData> composeRoutes(GlobalKey<NavigatorState> navigationLayoutKey, GlobalKey<NavigatorState> entryLayoutKey) => <IRoutingGraphData>[];

  @override
  Widget compose(BuildContext context, Size windowSize, Size pageSize) {
    final T theme = ThemingUtils.get<T>(context);

    return composeEntry(context, windowSize, theme);
  }
}

/// Stores the configuration of a CSMPackageLanding entry, meaning this will configure how the
/// button and the component will be displayed in the package landing application.
final class PackageLandingEntry<TThemeB extends PackageLandingThemeBase> extends PackageLandingEntryBase<TThemeB> {
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
