import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart';

/// Represents a { CSM } framework base navigation layout node.
abstract interface class INavigationLayoutNode {
  /// Navigation button title.
  final String title;

  /// Navigation button target route.
  final RouteData routeData;

  /// Button icon builder.
  final ImageProvider Function(BuildContext context) iconBuilder;

  /// Creates a new [INavigationLayoutNode] instance.
  const INavigationLayoutNode({
    required this.title,
    required this.routeData,
    required this.iconBuilder,
  });
}
