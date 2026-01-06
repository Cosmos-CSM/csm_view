import 'dart:async';

import 'package:flutter/material.dart';

/// Represents an [IEntity] based table adapter configuration.
abstract interface class IEntityTableAdapter {
  /// Creates a new instance.
  const IEntityTableAdapter();

  /// Composes the auth token to use for direct {csm} services comunication.
  FutureOr<String> composeAuth();

  /// Adds a callback action triggered when the [refresh] operation has been called.
  ///
  /// [callback] action callback to subscribe to notifier handle.
  void listenRefresh(VoidCallback callback);

  /// Refreshes the [EntityTable] instance adapted.
  void refresh();

  /// Disposes [IEntityTableAdapter] instance resources.
  void dispose();
}
