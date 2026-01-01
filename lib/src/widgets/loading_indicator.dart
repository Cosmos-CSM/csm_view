import 'package:flutter/material.dart';

/// {widget} class.
///
/// Draws a designed loading progress indicator.
class LoadingIndicator extends StatelessWidget {
  /// Circule color.
  final Color foreColor;

  /// Boxfit behavior.
  final BoxFit fit;

  /// Padding.
  final EdgeInsets padding;
  const LoadingIndicator({
    super.key,
    required this.foreColor,
    this.padding = const EdgeInsets.symmetric(
      horizontal: 18,
      vertical: 8,
    ),
    this.fit = BoxFit.fitHeight,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: FittedBox(
        fit: fit,
        child: Column(
          spacing: 8,
          children: <Widget>[
            CircularProgressIndicator(
              strokeWidth: 3,
              backgroundColor: Colors.transparent,
              color: foreColor,
            ),
            Text(
              'Loading...',
              style: TextStyle(
                fontSize: 10,
                color: foreColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
