import 'package:csm_view/csm_view.dart' hide LayoutBuilder;
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

/// Default [PackageLanding] home [Route] value.
final Route _homeRoute = Route(
  '',
  name: 'Home',
);

/// {widget} class.
///
///
/// [TBase] type of your [abstract] class definition for custom theme implementations.
///
///
/// Provides a complex detailed view for a [Package] development example. Allowing to interact in user-time with the objects
/// created in the package and test them manually, also works to create a documentation portal for developers internally and can be published.
final class PackageLanding<TBase extends LandingThemeB> extends StatefulWidget {
  /// Package name.
  final String name;

  /// Package description.
  final DescriptionBuilder<TBase> description;

  /// Default initial view theme.
  final TBase defaultTheme;

  /// Available [ThemeDataB] implementations to be handled by the [ThemeManagerI] for application theme interactions.
  final List<TBase> themes;

  /// Callback when the landing application is about to end {Init} phase time.
  final VoidCallback? onInit;

  /// Package playground entry.
  final List<PackageLandingEntryI<TBase>> landingEntries;

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
  State<PackageLanding<TBase>> createState() => _PackageLandingState<TBase>();
}

/// {state} class.
///
/// Handles [State] for [PackageLanding] {widget}.
final class _PackageLandingState<TBase extends LandingThemeB> extends State<PackageLanding<TBase>> {
  final GlobalKey<NavigatorState> _entryLayoutKey = GlobalKey();

  final GlobalKey<NavigatorState> _navigationLayoutKey = GlobalKey();

  /// {state} Stores the current [PackageLanding] route tree being handled for navigation.
  late Map<Route, PackageLandingEntryI<TBase>> navigationTree;

  /// {state} Stores the current relation between its [PackageLandingEntryI]<[TBase]> and
  late Map<Route, PackageLandingEntryI<TBase>> entryTree;

  late List<RouteB> routes = <RouteB>[];

  ///
  List<TBase> calculateApplicationThemes() {
    final List<TBase> applicationThemes = <TBase>[
      widget.defaultTheme,
      ...widget.themes,
    ];

    final List<TBase> applicationUniqueThemes = <TBase>[];

    for (TBase theme in applicationThemes) {
      final bool alreadySet = applicationUniqueThemes.any((TBase item) => item.identifier == theme.identifier);
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
  void didUpdateWidget(covariant PackageLanding<TBase> oldWidget) {
    if (oldWidget.landingEntries != widget.landingEntries) {
      calculateTrees();
    }

    super.didUpdateWidget(oldWidget);
  }

  /// Calculates a simulation trees for {navigation} and another one to store {landingEntries}, this ones to detect where
  /// the navigation is at and what is the correct components to display.
  void calculateTrees() {
    navigationTree = <Route, PackageLandingEntryI<TBase>>{};
    entryTree = <Route, PackageLandingEntryI<TBase>>{};

    routes = <RouteB>[];
    for (PackageLandingEntryI<TBase> landingEntry in widget.landingEntries) {
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

  /// Gets the current [PackageLandingEntryI]<[TBase]> based on the current navigation [Route].
  PackageLandingEntryI<TBase> getEntry(Route currRoute) {
    return entryTree.entries
        .firstWhere(
          (MapEntry<Route, PackageLandingEntryI<TBase>> element) => element.key == currRoute,
        )
        .value;
  }

  @override
  Widget build(BuildContext context) {
    final List<TBase> applicationThemes = calculateApplicationThemes();

    return ViewRoot(
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
                pageBuilder: (BuildContext ctx, _) => _PackageLandingWelcome<TBase>(
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
                  PackageLandingEntryI<TBase> landingEntry = getEntry(routeData.route);

                  return _PackageLandingEntryLayout<TBase>(
                    page: page,
                    routeData: routeData,
                    landingEntry: landingEntry,
                  );
                },
              ),
            ],
            layoutBuilder: (BuildContext ctx, RouteData routeData, Widget page) {
              return _PackageLandingLayout<TBase>(
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
        widget.onInit?.call();
      },
      builder: (BuildContext buildContext, Widget? app) {
        LandingThemeB theme = Theming.get(buildContext);

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
