part of '../navigation_layout.dart';

/// Draws the [NavigationLayout] on small devices view.
final class _NavigationLayoutSmallView extends _NavigationLayoutViewBase {
  /// Creates a new instance.
  _NavigationLayoutSmallView({
    super.userData,
    required super.page,
    required super.pageSize,
    required super.routingData,
    required super.navigationNodes,
  });

  @override
  Widget build(BuildContext context) {
    return ErrorWidget(
      'View not avialable for { Navigation Layout Small View }',
    );
  }
}
