import 'package:csm_view/csm_view.dart';
import 'package:flutter/material.dart';

/// Widget class for [AdaptiveWidget].
///
/// Defines UI for a [AdaptiveWidget] implementation.
///
/// [AdaptiveWidget] concept: handle draw decission based on specific running plarform, specifying what to draw when
/// the device is a desktop, mobile, or web application.
final class AdaptiveWidget extends StatelessWidget {
  /// [Widget] to draw when the running platform is desktop context.
  final Widget? onDesktop;

  /// [Widget] to draw when the running platform is mobile context.
  final Widget? onMobile;

  /// [Widget] to draw when the running platform is web browser context.
  final Widget? onBrowser;

  /// Generates a new [AdaptiveWidget] context.
  const AdaptiveWidget({
    super.key,
    this.onDesktop,
    this.onMobile,
    this.onBrowser,
  });

  @override
  Widget build(BuildContext context) {
    if (Domain.isWeb && onBrowser == null || Domain.isMobile && onMobile == null || Domain.isDesktop && onDesktop == null) {
      return ErrorWidget("You're on ${Domain.context.name} and the value provided is null");
    }

    if (Domain.isWeb) return onBrowser as Widget;
    if (Domain.isDesktop) return onDesktop as Widget;
    return onMobile as Widget;
  }
}
