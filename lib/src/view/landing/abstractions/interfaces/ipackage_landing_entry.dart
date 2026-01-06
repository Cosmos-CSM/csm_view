import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart';

/// Represents a package [PackageLandingViewBase] showcase entry.
abstract interface class IPackageLandingEntry<T extends PackageLandingThemeBase> implements IViewPage {
  /// The name of the component.
  final String name;

  /// Image to represent the package at the [Welcome] page cards.
  final ImageProvider? image;

  /// The component description.
  final DescriptionBuilder<T> description;

  /// Creates a new [IPackageLandingEntry] instance.
  const IPackageLandingEntry({
    this.image,
    required this.name,
    required this.description,
  });

  /// Composes nested [RouteB] implementations when the {entry} inner component needs to access a navigation route by its own behavior.
  List<IRoutingGraphData> composeRoutes(GlobalKey<NavigatorState> navigationLayoutKey, GlobalKey<NavigatorState> entryLayoutKey) => <IRoutingGraphData>[];

  /// Custom composition method for [IPackageLandingEntry] implementations to bypass [IPage], [compose].
  Widget composeEntry(BuildContext buildContext, Size windowSize, T theme);
}
