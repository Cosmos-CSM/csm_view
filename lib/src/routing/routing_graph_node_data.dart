import 'package:csm_view/csm_view.dart';

/// Represents a [RoutingGraphBase] node data.
final class RoutingGraphNodeData extends RoutingGraphNodeDataBase {
  /// Creates a new instance.
  const RoutingGraphNodeData(
    super.routeOptions, {
    required super.pageBuilder,
    super.parentNavigationState,
    super.nestedRoutes,
    super.redirection,
    super.transitionBuilder,
    super.onDispose,
  });
}
