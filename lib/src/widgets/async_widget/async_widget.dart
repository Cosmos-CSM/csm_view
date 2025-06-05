import 'dart:async';
import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart';

part 'async_widget_error.dart';
part 'async_widget_progress.dart';

/// [Widget] class for [AsyncWidget].
///
///
/// [T] type of the result data object for the [Future] invokation.
///
/// Defines a complex [Widget] that handles asynchronous calls to wait for a result data object, drawing
/// different views depending on the [Future] invokation state and custom given building evaluations.
final class AsyncWidget<T> extends StatefulWidget {
  /// Forced time to await before perfoming the consumption.
  final Duration? delay;

  /// Agent to perform actions to the component state instance.
  final AsyncWidgetController? agent;

  /// Native implementation asynchronouse abtraction of service call.
  final FutureOr<T> future;

  /// Wheter consider an empty object as error.
  final bool Function(T data)? emptyCheck;

  /// Custom [Widget] builder to display when the [AsyncWidget] is awaiting for the response.
  final Widget Function(BuildContext ctx)? loadingBuilder;

  /// [Widget] UI built when the [AsyncWidget] gets the consumption resolved as success.
  final Widget Function(BuildContext ctx, T data) successBuilder;

  /// Custom [Widget] builder to display when the [AsyncWidget] encounters an error.
  final Widget Function(BuildContext ctx, Object? error, T? data)? errorBuilder;

  /// Dart doesn't have a way to determine a Future<'T> Function is a Future<'void>, it has to be
  /// set manually tho.
  final bool isVoid;

  /// Whether [AsyncWidget] should cache the result [Widget] intself and don't rebuild it even though the
  /// state has received updates that doesn't affect the [future] data be re-fetched.
  ///
  ///
  /// NOTE: Originaly this [AsyncWidget] handles by default a cached widget builder function that
  /// recalls the last result [Widget] building passing [BuildContext] and last resolved [T] object result but this
  /// rebuilds the [Widget] every time the parent emits changes to this one, so enabling this option the [AsyncWidget] will
  /// cache a more deeper resuñted [Widget] instance and won't rebuilt it even though this [State] gets updated by the parent
  /// only will get rebuilt when [AsyncWidget] determines the [future] must be recalculated, this when [future] function references changes or when [agent] reference changes.
  final bool isStatic;

  /// Creates a new [AsyncWidget] widget.
  const AsyncWidget({
    super.key,
    this.delay,
    this.agent,
    this.emptyCheck,
    this.errorBuilder,
    this.loadingBuilder,
    this.isVoid = false,
    this.isStatic = false,
    required this.future,
    required this.successBuilder,
  });

  @override
  State<AsyncWidget<T>> createState() => _AsyncWidgetState<T>();
}

/// (private) [State] class for [AsyncWidget].
///
/// Handles the [State] behavior for [AsyncWidget].
class _AsyncWidgetState<TData> extends State<AsyncWidget<TData>> {
  /// Cached [Widget] when this is static and one has been resulted.
  Widget? cachWidget;

  /// Cached [Widget] builder for performance improvements.
  Widget Function()? cachWidgetBuilder;

  /// Cached [Future] invokation metadata.
  late Future<TData> cachFuture = _delayConsume();

  /// Stores the last Future connection state result.
  late ConnectionState connState;

  @override
  void initState() {
    connState = ConnectionState.none;
    widget.agent?.addListener(_refreshFuture);
    super.initState();
  }

  @override
  void didUpdateWidget(covariant AsyncWidget<TData> oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.agent != widget.agent) {
      cachWidgetBuilder = null;
      connState = ConnectionState.none;
      oldWidget.agent?.removeListener(_refreshFuture);
      widget.agent?.addListener(_refreshFuture);
    }

    if (widget.future != oldWidget.future) {
      connState = ConnectionState.none;
      cachWidget = null;
      cachWidgetBuilder = null;
      cachFuture = _delayConsume();
    }

    if ((oldWidget.isStatic != widget.isStatic) && widget.isStatic && cachWidgetBuilder != null) {
      cachWidget = cachWidgetBuilder!();
    }
  }

  /// Refreshes the current [cachFuture], re-fetching the data and re-building the resulted [Widget].
  void _refreshFuture() {
    setState(() {
      cachWidget = null;
      cachWidgetBuilder = null;
      connState = ConnectionState.none;
      cachFuture = _delayConsume();
    });
  }

  /// Applies the [widget.delay] given to the [widget.future] given.
  Future<TData> _delayConsume() async {
    if (widget.delay != null) {
      await Future<void>.delayed(widget.delay as Duration);
    }
    
    return widget.future;
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isStatic && cachWidget != null) {
      return cachWidget!;
    }

    return cachWidgetBuilder != null && connState == ConnectionState.done
        ? cachWidgetBuilder!()
        : FutureBuilder<TData>(
            future: cachFuture,
            builder: (BuildContext context, AsyncSnapshot<TData> snapshot) {
              // --> Connection state is loading.
              if (snapshot.connectionState != ConnectionState.done) {
                cachWidgetBuilder = () => widget.loadingBuilder?.call(context) ?? const _AsyncWidgetProgress();
              } else {
                // --> The consumer has reached an exception/error.
                if (snapshot.hasError ||
                    ((snapshot.data == null && (!widget.isVoid)) ||
                        (widget.emptyCheck != null && widget.emptyCheck!.call(snapshot.data as TData)))) {
                  cachWidgetBuilder = () =>
                      widget.errorBuilder?.call(context, snapshot.error, snapshot.data) ?? const _AsyncWidgetError();
                } else {
                  cachWidgetBuilder = () => widget.successBuilder(context, snapshot.data as TData);
                }
              }

              if (widget.isStatic) {
                cachWidget = cachWidgetBuilder!();
              }

              connState = snapshot.connectionState;
              return AnimatedSwitcher(
                duration: 600.miliseconds,
                switchInCurve: Curves.decelerate,
                child: cachWidgetBuilder!(),
              );
            },
          );
  }
}
