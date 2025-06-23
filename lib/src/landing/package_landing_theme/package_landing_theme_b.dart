import 'package:csm_view/csm_view.dart';


///
abstract class LandingThemeB extends ThemeDataB {
  /// Application pages [SimpleTheming] options.
  final SimpleTheming pageTheming;

  /// Application header [SimpleTheming] options.
  final SimpleTheming headerTheming;

  /// application [Welcome] page landing entries cards [SimpleTheming] options.
  final SimpleTheming welcomeCardTheming;

  /// Creates a new [LandingThemeB] instance.
  const LandingThemeB(
    super.identifier, {
    required super.icon,
    required super.iconBackground,
    required this.pageTheming,
    required this.headerTheming,
    required this.welcomeCardTheming,
  });
}
