import 'dart:async';
import 'package:csm_view/csm_view.dart';
import 'package:csm_view/src/widgets/agents/csm_consumer_agent.dart';
import 'package:flutter/material.dart';

part 'async_widget_error.dart';
part 'async_widget_progress.dart';

/// Widget class for [AsyncWidget].
///
/// Defines UI for a [AsyncWidget] implementation.
///
/// [TData] - The type of data to be consumed.
///
/// [AsyncWidget] concept: draws a complex UI based on a network request consuming.
final class AsyncWidget<TData> extends StatefulWidget {
  /// Native implementation asynchronouse abtraction of service call.
  final Future<TData> Function() consume;

  /// Forced time to await before perfoming the consumption.
  final Duration? delay;

  /// Wheter consider an empty object as error.
  final bool Function(TData data)? emptyCheck;

  /// Custom [Widget] builder to display when the [AsyncWidget] is awaiting for the response.
  final Widget Function(BuildContext ctx)? loadingBuilder;

  /// Custom [Widget] builder to display when the [AsyncWidget] encounters an error.
  final Widget Function(BuildContext ctx, Object? error, TData? data)? errorBuilder;

  /// [Widget] UI built when the [AsyncWidget] gets the consumption resolved as success.
  final Widget Function(BuildContext ctx, TData data) successBuilder;

  /// Agent to perform actions to the component state instance.
  final CSMConsumerAgent? agent;

  /// Dart doesn't have a way to determine a Future<'T> Function is a Future<'void>, it has to be
  /// set manually tho.
  final bool isVoid;

  /// Generates a new [AsyncWidget] widget.
  const AsyncWidget({
    super.key,
    this.isVoid = false,
    this.loadingBuilder,
    this.errorBuilder,
    this.delay,
    this.agent,
    this.emptyCheck,
    required this.consume,
    required this.successBuilder,
  });

  @override
  State<AsyncWidget<TData>> createState() => _AsyncWidgetState<TData>();
}

class _AsyncWidgetState<TData> extends State<AsyncWidget<TData>> {
  late Future<TData> consume;

  @override
  void initState() {
    consume = _delayConsume();
    widget.agent?.addListener(_refreshConsume);

    super.initState();
  }

  @override
  void didUpdateWidget(covariant AsyncWidget<TData> oldWidget) {
    if (oldWidget.agent != widget.agent) {
      widget.agent?.addListener(_refreshConsume);
    }

    super.didUpdateWidget(oldWidget);
  }

  void _refreshConsume() {
    setState(() {
      consume = _delayConsume();
    });
  }

  /// Applies the [widget.delay] given to the [widget.consume] given.
  Future<TData> _delayConsume() async {
    if (widget.delay != null) await Future<void>.delayed(widget.delay as Duration);

    return widget.consume();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<TData>(
      future: consume,
      builder: (BuildContext context, AsyncSnapshot<TData> snapshot) {
        late final Widget display;

        // --> Connection state is loading.
        if (snapshot.connectionState != ConnectionState.done) {
          display = widget.loadingBuilder?.call(context) ?? const _AsyncWidgetProgress();
        } else {
          // --> The consumer has reached an exception/error.
          if (snapshot.hasError || ((snapshot.data == null && (!widget.isVoid)) || (widget.emptyCheck != null && widget.emptyCheck!.call(snapshot.data as TData)))) {
            display = widget.errorBuilder?.call(context, snapshot.error, snapshot.data) ?? const _AsyncWidgetError();
          } else {
            display = widget.successBuilder(context, snapshot.data as TData);
          }
        }

        return AnimatedSwitcher(
          duration: 600.miliseconds,
          switchInCurve: Curves.decelerate,
          child: display,
        );
      },
    );
  }
}
