import 'package:flutter/material.dart';

/// [Interface] for [LayoutI] implementations.
///
/// A [LayoutI] is a custom view concept that usually nests different routing outputs into intself working as a static / base
/// view along different routing results, like a pattern around the routing result content.
abstract interface class LayoutI {
  /// Content to be wrapped by the [LayoutI].
  final Widget page;

  /// Creates a new [LayoutI] object.
  const LayoutI(this.page);
}
