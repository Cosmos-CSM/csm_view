import 'package:csm_view/csm_view.dart';

/// [class] implementation for [RouteLayoutB].
///
///
/// Defines and holds behavior for a configuralte [RouteLayout] node at the [Router] tree.
final class RouteLayout extends RouteLayoutB {
  /// Creates a [RouteLayout] object.
  const RouteLayout({
    required super.layoutBuilder,
    required super.routes,
    super.parentNavigatorStateKey,
    super.restoration,
    super.navigatorStateKey,
    super.observers,
    super.transitionBuild,
    super.redirection,
  });
}
