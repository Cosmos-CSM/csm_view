import 'package:csm_view/csm_view.dart';

/// Represents a [PackageLandingView] theme data.
abstract class PackageLandingThemeBase extends ThemeDataBase {
  /// Application pages [SimpleTheming] options.
  final SimpleTheming pageTheming;

  /// Application header [SimpleTheming] options.
  final SimpleTheming headerTheming;

  /// application [Welcome] page landing entries cards [SimpleTheming] options.
  final SimpleTheming welcomeCardTheming;

  /// Creates a new [PackageLandingThemeBase] instance.
  const PackageLandingThemeBase(
    super.identifier, {
    required super.icon,
    required super.iconBackground,
    required this.pageTheming,
    required this.headerTheming,
    required this.welcomeCardTheming,
  });
}
