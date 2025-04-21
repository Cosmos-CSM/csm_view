

import 'package:csm_view/csm_view.dart';

/// [class] implementation for [RouteNodeB]
///
/// 
/// Defines behavior for a [RouteNodeB] which is a [Router] calculation node tree.
final class RouteNode extends RouteNodeB {
  /// Creates a [RouteNode] object.
  const RouteNode(
    super.routeOptions, {
    required super.pageBuilder,
    super.parentNavigatorStateKey,
    super.routes,
    super.redirection,
    super.transitionBuilder,
    super.onDispose,
  });
}
