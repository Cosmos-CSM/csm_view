import 'package:csm_view/csm_view.dart';
import 'package:flutter/widgets.dart';

/// Represents a { CSM } framework base navigation layout node.
abstract class NavigationLayoutNodeBase implements INavigationLayoutNode {
  /// Navigation button title.
  @override
  final String title;

  /// Navigation button target route.
  @override
  final RouteData routeData;

  /// Button icon builder.
  @override
  final ImageProvider Function(BuildContext context) iconBuilder;

  /// Creates a new instance.
  const NavigationLayoutNodeBase({
    required this.title,
    required this.routeData,
    required this.iconBuilder,
  });
}
