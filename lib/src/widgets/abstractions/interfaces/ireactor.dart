import 'package:flutter/material.dart';
import 'package:csm_view/csm_view.dart';

/// Represents a [ReactorWidget]'s reactor to manage inner states.
abstract interface class IReactor implements Listenable {
  /// Indicates a state recalculation instruction.
  void react();
}
