import 'package:csm_view/src/routing/route_whisper/route_whisper_options.dart';

/// [interface] for [RouteWhisperI].
///
///
/// Defines constract for [RouteWhisperI] implementations which are [Router] specific nodes to handle complex layouts.
abstract interface class RouteWhisperI {
  /// Options for this [RouteWhisperI].
  final RouteWhisperOptions whisperOptions;

  /// Creates a new [RouteWhisperI] instance.
  const RouteWhisperI({
    required this.whisperOptions,
  });
}
