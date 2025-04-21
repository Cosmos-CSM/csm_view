import 'dart:async';

import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart' hide Route, Router;

/// [interface] for [RouteNodeI].
///
/// Defines a behavior for a [RouteNodeI] implementation wich is a [Router] calculation node determining it as a final visible
/// route path to be renderized and interactable.
abstract interface class RouteNodeI {
  /// Route information.
  final Route route;

  /// Builder function to build and renderize [PageI] into the interactable [Widget] tree.
  final PageBuilder pageBuilder;

  /// When the client enters into this route, will be redirected to this resolved [Redirection] function.
  final Redirection? redirection;

  /// Builder for [PageI] transitions along [Router] events.
  final Page<void> Function(PageI page)? transitionBuilder;

  /// Callback invoked when the current [route] is popped or removed from the [Router] history.
  ///
  /// .go() and .pop() removes from history.
  final FutureOr<bool> Function(BuildContext ctx, RouteData routeData)? onDispose;

  /// Creates a new [RouteNodeI] instance.
  const RouteNodeI(this.route, this.pageBuilder, this.redirection, this.transitionBuilder, this.onDispose);

  /// Calculates the node path based on the parse if it has parent nodes.
  ///
  /// [isSub] Wheter the current node has a parent node.
  String resolvePath([bool isSub = false]);
}
