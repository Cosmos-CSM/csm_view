import 'package:csm_view/csm_view.dart';

///
abstract class PackageLandingThemeB extends ThemeB {
  /// Application pages [SimpleTheming] options.
  final SimpleTheming pageTheming;

  /// Application header [SimpleTheming] options.
  final SimpleTheming headerTheming;

  /// application [Welcome] page landing entries cards [SimpleTheming] options.
  final SimpleTheming welcomeCardTheming;

  

  /// Creates a new [PackageLandingThemeB] instance.
  const PackageLandingThemeB(
    super.identifier, {
    required super.icon,
    required super.iconBackground,
    required this.pageTheming,
    required this.headerTheming,
    required this.welcomeCardTheming,
  });
}
