import 'package:csm_view/src/widgets/reactive_widget/reactor_i.dart';
import 'package:flutter/material.dart';

/// [interface] for [ReactiveWidgetI].
///
///
/// Defines behavior for a [ReactiveWidgetI] implementation wich is a [Widget] that handles state management internally
/// independent from the route tree rebuild.
abstract interface class ReactiveWidgetI<T extends ReactorI> {
  /// [Widget] reactor.
  final T reactor;

  /// Creates a new [ReactiveWidgetI] instance.
  const ReactiveWidgetI(this.reactor);

  /// [Widget] view building proxy to rebuild after a [reactor] instruction.
  Widget compose(BuildContext ctx, T reactor);
}
