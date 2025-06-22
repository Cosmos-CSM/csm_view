import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart';

/// [Interface] for [LayoutI] implementations.
///
/// A [LayoutI] is a custom view concept that usually nests different routing outputs into intself working as a static / base
/// view along different routing results, like a pattern around the routing result content.
abstract interface class LayoutI extends Widget {
  /// Content to be wrapped by the [LayoutI].
  final Widget page;

  /// Resolved routing data.
  final RouteData routeData;

  /// Creates a new [LayoutI] object.
  const LayoutI(
    this.page,
    this.routeData, {
    super.key,
  });
}

/// [abstract] for [LayoutB] implementations.
///
/// A [LayoutB] is a custom view concept that usually nests different routing outputs into intself working as a static / base
/// view along different routing results, like a pattern around the routing result content.
abstract class LayoutB extends PageB implements LayoutI {
  /// Content to be wrapped by the [LayoutB].
  @override
  final Widget page;

  /// Resolved routing data.
  @override
  final RouteData routeData;

  /// Generates a [LayoutB] behavior handler.
  const LayoutB({
    super.key,
    required this.page,
    required this.routeData,
  });
}
