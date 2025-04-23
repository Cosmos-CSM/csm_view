import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart' hide LayoutBuilder, Router;

/// [interface] for [RouteLayoutI].
///
/// Defines a behavior for a routing layout configuration that is a routing node where a shared layout should be
/// build for several configured routing end nodes to be wrapped from.
abstract interface class RouteLayoutI extends RouteB {
  /// Identifier to the restoration scope along [Router]´s implementation restoration manager.
  final String? restoration;

  /// Used to subscribe custom observers at the [Router] native framwork.
  final List<NavigatorObserver>? observers;

  /// Current [Navigator] state global access key.
  final NavigationState? navigatorStateKey;

  /// Handles the build for a dynamic transition at the routing event.
  final Page<dynamic> Function(LayoutB layout)? transitionBuild;

  /// When the client enters into this route, will be redirected to this resolved redirect function.
  final Redirection? redirection;

  /// Build function to create the [Layout] UI and draw it in the screen.
  final LayoutBuilder layoutBuilder;

  const RouteLayoutI(
    this.transitionBuild,
    this.layoutBuilder,
    this.restoration,
    this.navigatorStateKey,
    this.observers,
    this.redirection,
  );
}
