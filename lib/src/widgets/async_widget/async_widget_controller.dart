import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart';

/// [controller] class for [AsyncWidget].
///
///
/// Defines an object that allow to communicate and call instructions for the [AsyncWidget] this [controller] is
/// linked to.
final class AsyncWidgetController extends ChangeNotifier {
  /// Indicates the [AsyncWidget] to recalculate its data.
  void refresh() {
    notifyListeners();
  }
}
