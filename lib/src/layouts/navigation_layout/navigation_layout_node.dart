import 'package:csm_view/csm_view.dart';

/// {model} class.
///
/// Implements a data {model} that stores information to correctly build a Navigation Menu button and its routing behavior.
final class NavigationLayoutNode extends NavigationLayoutNodeBase {
  /// Creates a new [NavigationLayoutNode] instance.
  const NavigationLayoutNode({
    required super.title,
    required super.routeData,
    required super.iconBuilder,
  });
}
