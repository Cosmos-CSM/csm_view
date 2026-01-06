import 'dart:async';

import 'package:csm_client_core/csm_client_core.dart';
import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart';

/// Draws a generic {Create} action button for [CategoryLayoutPageI] acitons ribbon.
final class ActionsRisbbonCreate extends ActionsRibbonActionBase {
  /// Callback invoked when the action is requested.
  final FutureOr<void> Function() onCreate;

  /// Callback invoked to validate if the action can be executed at the current context.
  final FutureOr<List<UserFeedback>> Function()? onCanExecute;

  /// Creates a new [ActionsRisbbonCreate] instance.
  const ActionsRisbbonCreate({
    required this.onCreate,
    this.onCanExecute,
  }) : super(
          title: 'Create',
          description: 'Opens an Wizard to create new data',
        );

  @override
  FutureOr<void> perform() => onCreate();

  @override
  FutureOr<List<UserFeedback>>? canExecute() {
    if (onCanExecute == null) return null;

    return onCanExecute?.call();
  }

  @override
  Icon composeIcon(Color foreColor) {
    return Icon(
      Icons.add_box_outlined,
      color: foreColor,
    );
  }
}
