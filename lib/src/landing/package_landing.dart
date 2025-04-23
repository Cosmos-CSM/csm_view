import 'package:csm_view/csm_view.dart';
import 'package:csm_view/src/utils/injector.dart';
import 'package:csm_view/src/utils/theming.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' hide Route, Router;

part '_package_landing_device_details.dart';
part '_package_landing_entry_details.dart';
part '_package_landing_welcome.dart';
part '_package_landing_router.dart';

part '_package_landing_layout/_package_landing_layout.dart';
part '_package_landing_layout/_package_landing_layou_header.dart';

/// [Widget] class for [PackageLanding].
/// 
/// 
/// Provides a complex detailed view for a [Package] development example. Allowing to interact in user-time with the objects
/// created in the package and test them manually, also works to create a documentation portal for developers internally and can be published.
/// 
/// [TThemeB] type of your [abstract] class definition for custom theme implementations.
final class PackageLanding<TThemeB extends PackageLandingThemeB> extends StatelessWidget {
  
  /// Package name.
  final String name;

  /// Default initial view theme.
  final TThemeB defaultTheme;

  /// Available [ThemeB] implementations to be handled by the [ThemeManagerI] for application theme interactions.
  final List<TThemeB> themes;

  /// Package playground entry.
  final List<PackageLandingEntryI<TThemeB>> landingEntries;

  /// Createsa a new [PackageLanding] instance.
  const PackageLanding({
    super.key,
    required this.name,
    required this.defaultTheme,
    required this.themes,
    required this.landingEntries,
  });

  /// Calculates a simulated internal Route Tree based on the [landingEntries] configured, to store
  /// the reference for the [Route] object instances as they're needed for [Router] handling.
  Map<PackageLandingEntryI<TThemeB>, Route> calculateRouteTree() {
    final Map<PackageLandingEntryI<TThemeB>, Route> treeCache = <PackageLandingEntryI<TThemeB>, Route>{};

    for (PackageLandingEntryI<TThemeB> landingEntry in landingEntries) {
      final Route entryRoute = Route(landingEntry.name);
      treeCache[landingEntry] = entryRoute;
    }

    return treeCache;
  }

  ///
  List<TThemeB> calculateApplicationThemes() {
    final List<TThemeB> applicationThemes = <TThemeB>[
      defaultTheme,
      ...themes,
    ];

    final List<TThemeB> applicationUniqueThemes = <TThemeB>[];

    for (TThemeB theme in applicationThemes) {
      final bool alreadySet = applicationUniqueThemes.any((TThemeB item) => item.identifier == theme.identifier);
      if (!alreadySet) {
        applicationUniqueThemes.add(theme);
      }
    }

    return applicationUniqueThemes;
  }

  @override
  Widget build(BuildContext context) {
    final Map<PackageLandingEntryI<TThemeB>, Route> routingTree = calculateRouteTree();

    final List<TThemeB> applicationThemes = calculateApplicationThemes();

    return ViewRoot<TThemeB>(
      defaultTheme: defaultTheme,
      themes: applicationThemes,
      listenFrame: false,
      routerConfig: _PackageLandingRouter(
        routes: <RouteB>[
          RouteLayout(
            routes: <RouteB>[
              RouteNode(
                Route(
                  '',
                  name: 'home',
                ),
                pageBuilder: (BuildContext ctx, _) => _PackageLandingWelcome(),
              ),
              for (MapEntry<PackageLandingEntryI<TThemeB>, Route> routingLeaf in routingTree.entries) ...<RouteB>[
                RouteNode(
                  routingLeaf.value,
                  pageBuilder: (_, __) => routingLeaf.key,
                ),
              ],
            ],
            layoutBuilder: (BuildContext ctx, RouteData routeData, Widget page) {
              return _PackageLandingLayout(
                page: page,
                themes: applicationThemes,
              );
            },
          ),
        ],
      ),
      afterViewInit: () {
        final ThemeManagerI<TThemeB> themeManager = Injector.getThemeManager<TThemeB>();

        Injector.addSingleton<ThemeManagerI<PackageLandingThemeB>>(themeManager);
      },
    );
  }  
}
