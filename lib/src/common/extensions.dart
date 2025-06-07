import 'dart:typed_data';

import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart';

/// [Extension] for [String] type.
extension StringExtension on String {
  /// Calculates and returns if the current [String] starts with uppercase.
  bool get startUppercase {
    final String startLetter = substring(0, 1);
    return startLetter.toUpperCase() == startLetter;
  }

  /// Calculates and returns the [String] starting with uppercase.
  String toStartUpperCase() {
    if (startUppercase) return this;
    final String startLetter = substring(0, 1);
    return '${startLetter.toUpperCase()}${substring(1, length)}';
  }

  /// Converts the current [String] into an [Uint8List] using base64 convertion.
  Uint8List toByteArray() {
    return Uint8List.fromList(codeUnits);
  }
}

/// [Extension] for [int] type.
extension IntDuration on int {
  /// Gets the convertion to [Duration] object with the value as [seconds].
  Duration get seconds => Duration(seconds: this);

  /// Gets the convertion to [Duration] object with the value as [miliseconds].
  Duration get miliseconds => Duration(milliseconds: this);
}

/// Extension class.
/// Creates an extension from a list of specific class object.
///
/// We are creating an extension right here to create a method that will order
/// the current breakpoints list to be used anywhere.
extension PropertyBreakpointList<T> on List<ResponsivenessBreakpointValue<T>> {
  /// Will order the [List] of [ResponsivePropertyBreakpointOptions] in the correct
  /// logical order, from the lowest to the higher, and will discard the
  /// ilogical breakpoints detected.
  ///
  /// Returns the ordered [List] of [ResponsivePropertyBreakpointOptions].
  ///
  /// Note: Know as ilogical breakpoints, all repeated breakpoint value after the first one found will be removed.
  List<ResponsivenessBreakpointValue<T>> sortBreakpoints() {
    List<ResponsivenessBreakpointValue<T>> orderedList = this;
    orderedList.sort((ResponsivenessBreakpointValue<T> a, ResponsivenessBreakpointValue<T> b) =>
        a.breakpoint.compareTo(b.breakpoint));
    int point = 0;
    while (point < (orderedList.length - 1)) {
      final ResponsivenessBreakpointValue<T> currentItem = orderedList[point];
      final ResponsivenessBreakpointValue<T> nextItem = orderedList[point + 1];
      if (!(currentItem.breakpoint == nextItem.breakpoint)) continue;
      orderedList.removeAt(point + 1);
    }

    return orderedList;
  }
}

/// {extension} class.
///
/// Define extension methods for [BoxConstraints] type objects.
extension BoxConstraintsExtension on BoxConstraints {
  /// Boxes the constraints to match when unlimited [maxHeight] and(or) [maxWidth] are unbound.
  BoxConstraints boxed() {
    BoxConstraints boxedConstraints = this;

    if (!hasBoundedHeight) {
      boxedConstraints = tighten(
        height: minHeight,
      );
    }

    if (!hasBoundedWidth) {
      boxedConstraints = boxedConstraints.tighten(
        width: minWidth,
      );
    }

    return boxedConstraints;
  }
}
