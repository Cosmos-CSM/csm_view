import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart' hide Route;

/// [interface] for [PageI].
///
/// Defines the required behavior for a [PageI] implementation wich is taken as a [Route] visible user view to be
/// rendered.
abstract interface class PageI implements StatelessWidget {
  /// Composes a visible view as a [RouteNodeI] interactive page.
  Widget compose(BuildContext buildContext, Size windowSize);
}
