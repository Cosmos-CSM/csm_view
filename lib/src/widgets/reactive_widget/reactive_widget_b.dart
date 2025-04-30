import 'package:csm_view/csm_view.dart';
import 'package:flutter/widgets.dart';

/// [abtract] for [ReactiveWidgetB].
///
///
/// Defines and handles base behavior for [ReactiveWidgetB] implementations, wich are [Widget] that handles and manipulates
/// states internally independant from outside [Widget] tree rebuilds, restoring after a view refresh.
abstract class ReactiveWidgetB<T extends ReactorI> extends StatelessWidget implements ReactiveWidgetI<T> {
  /// [Widget] reactor.
  @override
  final T reactor;

  /// Creates a new [ReactiveWidgetB] widget.
  const ReactiveWidgetB({
    super.key,
    required this.reactor,
  });

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: reactor,
      builder: (BuildContext ctx, _) {
        return compose(ctx, reactor);
      },
    );
  }

  @override
  Widget compose(BuildContext ctx, T state);
}
