import 'package:csm_view/csm_view.dart' hide LayoutBuilder;
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

/// Default [PackageLanding] home [Route] value.
final Route _homeRoute = Route(
  '',
  name: 'Home',
);

/// {widget} class.
///
///
/// [T] type of your [abstract] class definition for custom theme implementations.
///
///
/// Provides a complex detailed view for a [Package] development example. Allowing to interact in user-time with the objects
/// created in the package and test them manually, also works to create a documentation portal for developers internally and can be published.
final class PackageLanding<T extends PackageLandingThemeB> extends StatefulWidget {
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

  @override
  State<PackageLanding<T>> createState() => _PackageLandingState<T>();
}

/// {state} class.
///
/// Handles [State] for [PackageLanding] {widget}.
final class _PackageLandingState<T extends PackageLandingThemeB> extends State<PackageLanding<T>> {
  final GlobalKey<NavigatorState> _entryLayoutKey = GlobalKey();

  final GlobalKey<NavigatorState> _navigationLayoutKey = GlobalKey();

  /// {state} Stores the current [PackageLanding] route tree being handled for navigation.
  late Map<Route, PackageLandingEntryI<T>> navigationTree;

  /// {state} Stores the current relation between its [PackageLandingEntryI]<[T]> and
  late Map<Route, PackageLandingEntryI<T>> entryTree;

  late List<RouteB> routes = <RouteB>[];

  ///
  List<T> calculateApplicationThemes() {
    final List<T> applicationThemes = <T>[
      widget.defaultTheme,
      ...widget.themes,
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
  void initState() {
    super.initState();
    calculateTrees();
  }

  @override
  void didUpdateWidget(covariant PackageLanding<T> oldWidget) {
    if (oldWidget.landingEntries != widget.landingEntries) {
      calculateTrees();
    }

    super.didUpdateWidget(oldWidget);
  }

  /// Calculates a simulation trees for {navigation} and another one to store {landingEntries}, this ones to detect where
  /// the navigation is at and what is the correct components to display.
  void calculateTrees() {
    navigationTree = <Route, PackageLandingEntryI<T>>{};
    entryTree = <Route, PackageLandingEntryI<T>>{};



    routes = <RouteB>[];
    for (PackageLandingEntryI<T> landingEntry in widget.landingEntries) {
      String entryRoutePath = landingEntry.name.toLowerCase().replaceAll(' ', '_');

      Route entryRoute = Route(entryRoutePath, name: landingEntry.name);

      navigationTree[entryRoute] = landingEntry;
      entryTree[entryRoute] = landingEntry;

      void nestedRoutesIterator(List<RouteB> nestedRoutes) {
        for (RouteB nestedRoute in nestedRoutes) {
          if (nestedRoute is RouteNodeB) {
            entryTree[nestedRoute.route] = landingEntry;
          }

          nestedRoutesIterator(nestedRoute.routes);
        }
      }
      
      List<RouteB> nestdRoutes = landingEntry.composeRoutes(_navigationLayoutKey, _entryLayoutKey);
      routes.add(
        RouteNode(
          entryRoute,
          routes: nestdRoutes,
          pageBuilder: (BuildContext ctx, RouteData routeData) => landingEntry,
        ),
      );
      nestedRoutesIterator(
        landingEntry.composeRoutes(_navigationLayoutKey, _entryLayoutKey),
      );
    }
  }

  /// Gets the current [PackageLandingEntryI]<[T]> based on the current navigation [Route].
  PackageLandingEntryI<T> getEntry(Route currRoute) {
    return entryTree.entries
        .firstWhere(
          (MapEntry<Route, PackageLandingEntryI<T>> element) => element.key == currRoute,
        )
        .value;
  }

  @override
  Widget build(BuildContext context) {
    final List<T> applicationThemes = calculateApplicationThemes();

    return ViewRoot<T>(
      defaultTheme: widget.defaultTheme,
      themes: applicationThemes,
      listenFrame: false,
      routerConfig: _PackageLandingRouter(
        routes: <RouteB>[
          /// --> Landing Navigation Layour
          RouteLayout(
            navigatorStateKey: _navigationLayoutKey,
            routes: <RouteB>[
              /// --> Home Route
              RouteNode(
                _homeRoute,
                pageBuilder: (BuildContext ctx, _) => _PackageLandingWelcome<T>(
                  packageName: widget.name,
                  routingTree: navigationTree,
                  packageDescription: widget.description,
                ),
              ),

              /// --> Entry Layout
              RouteLayout(
                routes: routes,
                navigatorStateKey: _entryLayoutKey,
                layoutBuilder: (BuildContext ctx, RouteData routeData, Widget page) {
                  PackageLandingEntryI<T> landingEntry = getEntry(routeData.route);

                  return _PackageLandingEntryLayout<T>(
                    page: page,
                    routeData: routeData,
                    landingEntry: landingEntry,
                  );
                },
              ),
            ],
            layoutBuilder: (BuildContext ctx, RouteData routeData, Widget page) {
              return _PackageLandingLayout<T>(
                page: page,
                routeData: routeData,
                themes: applicationThemes,
                routingTree: navigationTree,
              );
            },
          ),
        ],
      ),
      afterViewInit: () {
        final ThemeManagerI<T> themeManager = Injector.getThemeManager<T>();

        Injector.addSingleton<ThemeManagerI<PackageLandingThemeB>>(themeManager);

        widget.onInit?.call();
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
