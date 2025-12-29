import 'dart:async';

import 'package:csm_view/csm_view.dart' hide LayoutBuilder;
import 'package:csm_view/src/landing/abstractions/bases/package_landing_theme_base.dart';
import 'package:csm_view/src/landing/abstractions/interfaces/ipackage_landing_entry.dart';
import 'package:csm_view/src/theming/abstractions/interfaces/itheme_data.dart';
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

/// Default [PackageLandingView] home [RouteData] value.
final RouteData _homeRoute = RouteData(
  '',
  name: 'Home',
);

/// {widget} class.
///
///
/// [TPackageLandingThemeBase] type of your [abstract] class definition for custom theme implementations.
///
///
/// Provides a complex detailed view for a [Package] development example. Allowing to interact in user-time with the objects
/// created in the package and test them manually, also works to create a documentation portal for developers internally and can be published.
final class PackageLandingView<TPackageLandingThemeBase extends PackageLandingThemeBase> extends StatefulWidget {
  /// Package name.
  final String name;

  /// Package description.
  final DescriptionBuilder<TPackageLandingThemeBase> description;

  /// Default initial view theme.
  final TPackageLandingThemeBase defaultTheme;

  /// Available [IThemeData] implementations to be handled by the [ThemeManagerI] for application theme interactions.
  final List<TPackageLandingThemeBase> themes;

  /// Callback when the landing application is about to end {Init} phase time.
  final FutureOr<void> Function()? initDependencies;

  /// Package playground entry.
  final List<IPackageLandingEntry<TPackageLandingThemeBase>> landingEntries;

  /// Createsa a new [PackageLandingView] instance.
  const PackageLandingView({
    super.key,
    this.initDependencies,
    required this.name,
    required this.description,
    required this.defaultTheme,
    required this.themes,
    required this.landingEntries,
  });

  @override
  State<PackageLandingView<TPackageLandingThemeBase>> createState() => _PackageLandingViewState<TPackageLandingThemeBase>();
}

/// {state} class.
///
/// Handles [State] for [PackageLandingView] {widget}.
final class _PackageLandingViewState<TBase extends PackageLandingThemeBase> extends State<PackageLandingView<TBase>> {
  final GlobalKey<NavigatorState> _entryLayoutKey = GlobalKey();

  final GlobalKey<NavigatorState> _navigationLayoutKey = GlobalKey();

  /// {state} Stores the current [PackageLandingView] route tree being handled for navigation.
  late Map<RouteData, IPackageLandingEntry<TBase>> navigationTree;

  /// {state} Stores the current relation between its [PackageLandingEntryI]<[TBase]> and
  late Map<RouteData, IPackageLandingEntry<TBase>> entryTree;

  late List<IRoutingGraphData> routes = <IRoutingGraphData>[];

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
  void didUpdateWidget(covariant PackageLandingView<TBase> oldWidget) {
    if (oldWidget.landingEntries != widget.landingEntries) {
      calculateTrees();
    }

    super.didUpdateWidget(oldWidget);
  }

  /// Calculates a simulation trees for {navigation} and another one to store {landingEntries}, this ones to detect where
  /// the navigation is at and what is the correct components to display.
  void calculateTrees() {
    navigationTree = <RouteData, IPackageLandingEntry<TBase>>{};
    entryTree = <RouteData, IPackageLandingEntry<TBase>>{};

    routes = <IRoutingGraphData>[];
    for (IPackageLandingEntry<TBase> landingEntry in widget.landingEntries) {
      String entryRoutePath = landingEntry.name.toLowerCase().replaceAll(' ', '_');

      RouteData entryRoute = RouteData(entryRoutePath, name: landingEntry.name);

      navigationTree[entryRoute] = landingEntry;
      entryTree[entryRoute] = landingEntry;

      void nestedRoutesIterator(List<IRoutingGraphData> nestedRoutes) {
        for (IRoutingGraphData nestedRoute in nestedRoutes) {
          if (nestedRoute is RoutingGraphNodeDataBase) {
            entryTree[nestedRoute.route] = landingEntry;
          }

          nestedRoutesIterator(nestedRoute.nestedRoutes);
        }
      }

      List<IRoutingGraphData> nestdRoutes = landingEntry.composeRoutes(_navigationLayoutKey, _entryLayoutKey);
      routes.add(
        RoutingGraphNodeData(
          entryRoute,
          nestedRoutes: nestdRoutes,
          pageBuilder: (BuildContext ctx, RoutingData routeData) => landingEntry,
        ),
      );
      nestedRoutesIterator(
        landingEntry.composeRoutes(_navigationLayoutKey, _entryLayoutKey),
      );
    }
  }

  /// Gets the current [PackageLandingEntryI]<[TBase]> based on the current navigation [RouteData].
  IPackageLandingEntry<TBase> getEntry(RouteData currRoute) {
    return entryTree.entries
        .firstWhere(
          (MapEntry<RouteData, IPackageLandingEntry<TBase>> element) => element.key == currRoute,
        )
        .value;
  }

  @override
  Widget build(BuildContext context) {
    final List<TBase> applicationThemes = calculateApplicationThemes();

    return SolutionView.router(
      themes: applicationThemes,
      listenFrame: false,
      initDependencies: widget.initDependencies,
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
                layoutBuilder: (BuildContext ctx, RoutingData routeData, Widget page) {
                  PackageLandingEntryI<TBase> landingEntry = getEntry(routeData.targetRoute);

                  return _PackageLandingEntryLayout<TBase>(
                    page: page,
                    routeData: routeData,
                    landingEntry: landingEntry,
                  );
                },
              ),
            ],
            layoutBuilder: (BuildContext ctx, RoutingData routeData, Widget page) {
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
