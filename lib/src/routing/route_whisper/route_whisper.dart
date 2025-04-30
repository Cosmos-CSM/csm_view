import 'package:csm_view/csm_view.dart';

/// [class] implementation for [RouteWhisperB].
///
///
/// Defines a basic behavior implementation for a [RouteWhisperB].
final class RouteWhisper<T> extends RouteWhisperB<T> {
  /// Creates a new [RouteWhisper] instance.
  RouteWhisper(
    super.routeOptions, {
    required super.pageBuilder,
    required super.whisperOptions,
    super.routes,
    super.onDispose,
    super.redirection,
    super.parentNavigatorStateKey,
  });
}
