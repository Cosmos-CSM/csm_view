import 'package:csm_view/csm_view.dart' hide LayoutBuilder;
import 'package:csm_view/src/utils/injector.dart';
import 'package:csm_view/src/utils/theming.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' hide Route, Router;

part '_package_landing_entry_layout/_package_landing_device_details.dart';
part '_package_landing_router.dart';

part '_package_landing_layout/_package_landing_layout.dart';
part '_package_landing_layout/_package_landing_layout_menu.dart';
part '_package_landing_layout/_package_landing_layou_header.dart';

part '_page_landing_welcome/_package_landing_welcome.dart';
part '_page_landing_welcome/_package_landing_welcome_entry.dart';

part '_package_landing_entry_layout/_package_landing_entry_layout.dart';

///
final Route _homeRoute = Route(
  '',
  name: 'Home',
);

/// [Widget] class for [PackageLanding].
///
///
/// Provides a complex detailed view for a [Package] development example. Allowing to interact in user-time with the objects
/// created in the package and test them manually, also works to create a documentation portal for developers internally and can be published.
///
/// [T] type of your [abstract] class definition for custom theme implementations.
final class PackageLanding<T extends PackageLandingThemeB> extends StatelessWidget {
  /// Package name.
  final String name;

  /// Package description.
  final DescriptionBuilder<T> description;

  /// Default initial view theme.
  final T defaultTheme;

  /// Available [ThemeB] implementations to be handled by the [ThemeManagerI] for application theme interactions.
  final List<T> themes;

  /// Callback when the landing application is about to end {Init} phase time.
  final VoidCallback? onInit;

  /// Package playground entry.
  final List<PackageLandingEntryI<T>> landingEntries;

  /// Createsa a new [PackageLanding] instance.
  const PackageLanding({
    super.key,
    this.onInit,
    required this.name,
    required this.description,
    required this.defaultTheme,
    required this.themes,
    required this.landingEntries,
  });

  /// Calculates a simulated internal Route Tree based on the [landingEntries] configured, to store
  /// the reference for the [Route] object instances as they're needed for [Router] handling.
  Map<PackageLandingEntryI<T>, Route> calculateRouteTree() {
    final Map<PackageLandingEntryI<T>, Route> treeCache = <PackageLandingEntryI<T>, Route>{};

    for (PackageLandingEntryI<T> landingEntry in landingEntries) {
      final Route entryRoute = Route(
        landingEntry.name.toLowerCase().replaceAll(' ', '_'),
        name: landingEntry.name,
      );
      treeCache[landingEntry] = entryRoute;
    }

    return treeCache;
  }

  ///
  List<T> calculateApplicationThemes() {
    final List<T> applicationThemes = <T>[
      defaultTheme,
      ...themes,
    ];

    final List<T> applicationUniqueThemes = <T>[];

    for (T theme in applicationThemes) {
      final bool alreadySet = applicationUniqueThemes.any((T item) => item.identifier == theme.identifier);
      if (!alreadySet) {
        applicationUniqueThemes.add(theme);
      }
    }

    return applicationUniqueThemes;
  }

  @override
  Widget build(BuildContext context) {
    final Map<PackageLandingEntryI<T>, Route> routingTree = calculateRouteTree();

    final List<T> applicationThemes = calculateApplicationThemes();

    return ViewRoot<T>(
      defaultTheme: defaultTheme,
      themes: applicationThemes,
      listenFrame: false,
      routerConfig: _PackageLandingRouter(
        routes: <RouteB>[
          RouteLayout(
            routes: <RouteB>[
              RouteNode(
                _homeRoute,
                pageBuilder: (BuildContext ctx, _) => _PackageLandingWelcome<T>(
                  packageName: name,
                  routingTree: routingTree,
                  packageDescription: description,
                ),
              ),
              RouteLayout(
                layoutBuilder: (BuildContext ctx, RouteData routeData, Widget page) {
                  final PackageLandingEntryI<T> landingEntry = routingTree.entries
                      .where(
                        (MapEntry<PackageLandingEntryI<T>, Route> routingLeaf) {
                          return routingLeaf.value == routeData.route;
                        },
                      )
                      .first
                      .key;

                  return _PackageLandingEntryLayout<T>(
                    page: page,
                    landingEntry: landingEntry,
                  );
                },
                routes: <RouteB>[
                  for (MapEntry<PackageLandingEntryI<T>, Route> routingLeaf in routingTree.entries) ...<RouteB>[
                    RouteNode(
                      routingLeaf.value,
                      pageBuilder: (_, __) => routingLeaf.key,
                    ),
                  ],
                ],
              ),
            ],
            layoutBuilder: (BuildContext ctx, RouteData routeData, Widget page) {
              return _PackageLandingLayout<T>(
                page: page,
                routeData: routeData,
                themes: applicationThemes,
                routingTree: routingTree,
              );
            },
          ),
        ],
      ),
      afterViewInit: () {
        final ThemeManagerI<T> themeManager = Injector.getThemeManager<T>();

        Injector.addSingleton<ThemeManagerI<PackageLandingThemeB>>(themeManager);
        Injector.addSingleton<ThemeManagerI<T>>(themeManager);

        onInit?.call();
      },
      builder: (BuildContext context, Widget? app) {
        final PackageLandingThemeB theme = Theming.get();

        return ColoredBox(
          color: theme.pageTheming.back,
          child: Theme(
            data: ThemeData(
              textTheme: TextTheme(
                headlineSmall: TextStyle(
                  color: theme.pageTheming.fore,
                ),
              ),
            ),
            child: DefaultTextStyle(
              key: UniqueKey(),
              style: TextStyle(
                color: theme.pageTheming.fore,
              ),
              child: app!,
            ),
          ),
        );
      },
    );
  }
}
