import 'package:csm_view/csm_view.dart';

/// Represents a [RoutingGraphBase] layout route data.
final class RoutingGraphLayoutData extends RoutingGraphLayoutDataBase {
  /// Creates a [RoutingGraphLayoutData] object.
  const RoutingGraphLayoutData({
    required super.layoutBuilder,
    required super.nestedRoutes,
    super.parentNavigationState,
    super.restoration,
    super.navigatorStateKey,
    super.observers,
    super.transitionBuild,
    super.redirection,
  });
}
