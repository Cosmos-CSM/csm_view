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
    required super.page,
    required super.control,
    required this.pageTheming,
    required this.headerTheming,
    required super.controlError,
    required super.iconBackground,
    required super.controlSuccess,
    required this.welcomeCardTheming,
  });
}
