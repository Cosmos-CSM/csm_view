import 'package:csm_view/csm_view.dart';

/// Represents a [PackageLandingView] theme data.
abstract class PackageLandingThemeBase extends ThemeDataBase {
  /// Application pages [ThemingData] options.
  final ThemingData pageTheming;

  /// Application header [ThemingData] options.
  final ThemingData headerTheming;

  /// application [Welcome] page landing entries cards [ThemingData] options.
  final ThemingData welcomeCardTheming;

  /// Creates a new [PackageLandingThemeBase] instance.
  const PackageLandingThemeBase(
    super.identifier, {
    required super.icon,
    required super.iconBackground,
    required this.pageTheming,
    required this.headerTheming,
    required this.welcomeCardTheming,
    required super.controlTheming,
    required super.controlErrorTheming,
    required super.controlSuccessTheming,
  });
}
