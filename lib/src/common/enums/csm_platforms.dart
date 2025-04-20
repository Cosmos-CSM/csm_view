import 'package:flutter/material.dart';

/// Enum for [CSMPlatforms].
///
/// Defines an enumerator for a [CSMPlatforms] implementation.
///
///[CSMPlatforms] concept: describes a possible platform for the current application running context.
enum CSMPlatforms {

  web('Browser', Colors.amber),
  mobile('Mobile Device', Colors.deepOrangeAccent),
  desktop('Desktop Device', Colors.greenAccent);

  /// Descriptive name.
  final String name;

  /// Color identification.
  final Color color;

  const CSMPlatforms(this.name, this.color);

  @override
  String toString() => name;
}
