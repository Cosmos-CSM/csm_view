import 'dart:async';

import 'package:csm_view/csm_view.dart';
import 'package:csm_view/src/landing/abstractions/bases/package_landing_theme_base.dart';
import 'package:csm_view/src/landing/abstractions/interfaces/ipackage_landing_entry.dart';

///
abstract class PackageLandingViewBase<TLandingThemeBase extends PackageLandingThemeBase> extends ViewModuleBase {
  /// Package name.
  final String name;

  /// Package description.
  final DescriptionBuilder<TLandingThemeBase> description;

  /// Available [ThemeDataBase] implementations to be handled by the [ThemeManagerI] for application theme interactions.
  final List<TLandingThemeBase> themes;

  /// Callback when the landing application is about to end {Init} phase time.
  final FutureOr<void> Function()? initDependencies;

  /// Package playground entry.
  final List<IPackageLandingEntry<TLandingThemeBase>> landingEntries;

  const PackageLandingViewBase({
    super.key,
    this.initDependencies,
    required this.name,
    required this.description,
    required this.themes,
    required this.landingEntries,
  });

  @override
  List<TLandingThemeBase> bootstrapTheming();
}
