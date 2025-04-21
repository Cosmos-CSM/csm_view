import 'package:csm_view/src/widgets/form_widget/form_widget_controller.dart';
import 'package:flutter/material.dart';

/// [Widget] class for [FormWidget].
///
///
/// Draws a complex [Form] grouper view, handling build and interaction with a [Form] easier.
final class FormWidget extends StatelessWidget {
  /// [FormWidget] controller.
  final FormWidgetController controller;

  /// Form content.
  final Widget child;

  /// Creates a new [FormWidget] instance.
  const FormWidget({
    super.key,
    required this.child,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.key,
      autovalidateMode: controller.validateMode,
      canPop: controller.canDismiss,
      onChanged: controller.onChange,
      onPopInvokedWithResult: controller.onPop,
      child: child,
    );
  }
}
