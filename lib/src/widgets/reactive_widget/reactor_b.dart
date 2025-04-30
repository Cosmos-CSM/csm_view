import 'package:csm_view/src/widgets/reactive_widget/reactor_i.dart';
import 'package:flutter/foundation.dart';

/// [abstract] for [ReactorB].
///
/// Defines and handles [ReactorI] implementation, wich is an object that stores custom state data for [Widget]s that
/// are not necessary to be kept after a view refresh and only store in its own behavior context.
abstract class ReactorB extends ChangeNotifier implements ReactorI {
  @override
  @Deprecated('Wrong lexical CSM use, better use effect()')
  void notifyListeners() => react();

  @override
  void react() {
    super.notifyListeners();
  }
}
