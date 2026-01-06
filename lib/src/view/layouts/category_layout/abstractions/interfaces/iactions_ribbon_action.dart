import 'dart:async';

import 'package:csm_client_core/csm_client_core.dart';
import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart';

/// Represents a [CategoryLayout] action at the [ICategoryLayoutPage] actions ribbon.
abstract interface class IActionsRibbonAction implements IActionsRibbonNode {
  /// Action title.
  final String title;

  /// Action description.
  final String? description;

  /// Creates a new [IActionsRibbonAction] instance.
  const IActionsRibbonAction(
    this.title,
    this.description,
  );

  /// Composes the [Icon] to display for this [IActionsRibbonAction].
  ///
  ///
  /// [foreColor] current theme data recommended fore color.
  Icon composeIcon(Color foreColor);

  /// Validates if can be executed, if not will be displayed as disabled but when user clicks on it will display [messageBus] information.
  FutureOr<List<UserFeedback>>? canExecute();

  /// Performs the [IActionsRibbonAction] implementation functionality when the button [canExecute].
  FutureOr<void> perform();
}
