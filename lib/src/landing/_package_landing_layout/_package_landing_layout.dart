part of '../package_landing.dart';

/// [LayoutB] implementation for a [PackageLanding].
///
///
/// This layout draws the navigation view through the package configured entries.
final class _PackageLandingLayout extends LayoutB {
  ///
  final List<ThemeI> themes;

  const _PackageLandingLayout({
    required super.page,
    required this.themes,
  });

  @override
  Widget compose(BuildContext ctx, Size window) {
    return Column(
      children: <Widget>[
        _PackageLandingLayouHeader(
          themes: themes,
        ),
      ],
    );
  }
}
