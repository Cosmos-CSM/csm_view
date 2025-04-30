import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart';

/// [interface] for [ReactorI].
///
/// Defines a contract for [ReactorI] implementations used on [ReactiveWidget] to handle dynamic widget state recalculation.
abstract interface class ReactorI implements Listenable {
  /// Indicates a state recalculation instruction.
  void react();
}
