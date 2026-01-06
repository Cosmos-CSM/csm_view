import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart';

/// Draws a [Widget] that displays a property value.
final class PropertyViewer extends StatelessWidget {
  /// Property name.
  final String label;

  /// Property value.
  final String? value;

  /// Creates a new instance.
  const PropertyViewer({
    super.key,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    ThemingData pageTheme = ThemingUtils.get<IThemeData>(context).page;

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: <Widget>[
        Text(
          '$label:',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: pageTheme.fore,
          ),
        ),
        Text(
          value ?? '---',
          style: TextStyle(color: pageTheme.fore),
        ),
      ],
    );
  }
}
