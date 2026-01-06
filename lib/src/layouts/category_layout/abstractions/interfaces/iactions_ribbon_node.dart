import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart';

/// Represents a [CategoryLayoutActionsRibbon] node data.
abstract interface class IActionsRibbonNode {
  /// Composes the [IActionsRibbonNode] representation as a [Widget].
  Widget compose(GlobalKey<CategoryLayoutMessengerState> messengerRef);
}
