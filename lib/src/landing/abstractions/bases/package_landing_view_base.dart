import 'package:csm_view/csm_view.dart' hide LayoutBuilder;
import 'package:csm_view/src/core/utils/widget_adaption_utils.dart';
import 'package:csm_view/src/widgets/pointer_area.dart';
import 'package:csm_view/src/widgets/reactive_widget.dart';
import 'package:csm_view/src/widgets/theme_switcher.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

part '../../_package_landing_router.dart';

part '../../_package_landing_layout/_package_landing_layout.dart';
part '../../_package_landing_layout/_package_landing_layout_menu.dart';
part '../../_package_landing_layout/_package_landing_layou_header.dart';

part '../../_package_landing_entry_layout/_package_landing_entry_layout.dart';
part '../../_package_landing_entry_layout/_package_landing_device_details.dart';

part '../../_page_landing_welcome/_package_landing_welcome.dart';
part '../../_page_landing_welcome/_package_landing_welcome_entry.dart';

typedef _Graph<TThemeB extends PackageLandingThemeBase> = Map<RouteData, IPackageLandingEntry<TThemeB>>;

final RouteData _homeRouteData = RouteData(
  'home',
  name: 'home',
);

///
abstract class PackageLandingViewBase<TLandingThemeBase extends PackageLandingThemeBase> extends ViewModuleBase {
  /// Package name.
  final String name;

  /// Package description.
  final DescriptionBuilder<TLandingThemeBase> description;

  /// Package playground entry.
  final List<IPackageLandingEntry<TLandingThemeBase>> packageEntries;

  const PackageLandingViewBase({
    super.key,
    required this.name,
    required this.description,
    required this.packageEntries,
  });

  @override
  List<TLandingThemeBase> bootstrapTheming();

  @override
  RoutingGraphBase bootstrapRouting() {
    final NavigationState entriesLayoutKey = GlobalKey();
    final NavigationState navigationLayoutKey = GlobalKey();

    final (_Graph<TLandingThemeBase> navigationGraph, _Graph<TLandingThemeBase> packageEntriesGraph, List<IRoutingGraphData> routes) contextGraphs = composeContextGraphs(entriesLayoutKey, navigationLayoutKey);

    return _PackageLandingRoutingGraph(
      routes: <IRoutingGraphData>[
        /// --> Landing Navigation Layour
        RoutingGraphLayout(
          navigatorStateKey: navigationLayoutKey,
          routes: <IRoutingGraphData>[
            /// --> Home Route
            RoutingGraphNode(
              _homeRouteData,
              pageBuilder: (BuildContext ctx, _) => _PackageLandingWelcome<TLandingThemeBase>(
                packageName: name,
                routingGraph: contextGraphs.$1,
                packageDescription: description,
              ),
            ),

            /// --> Entry Layout
            RoutingGraphLayout(
              routes: contextGraphs.$3,
              navigatorStateKey: entriesLayoutKey,
              layoutBuilder: (BuildContext ctx, RoutingData routingData, Widget page) {
                IPackageLandingEntry<TLandingThemeBase> landingEntry = contextGraphs.$2.entries
                    .firstWhere(
                      (MapEntry<RouteData, IPackageLandingEntry<TLandingThemeBase>> element) => element.key == routingData.targetRoute,
                    )
                    .value;

                return _PackageLandingEntryLayout<TLandingThemeBase>(
                  page: page,
                  routingData: routingData,
                  landingEntry: landingEntry,
                );
              },
            ),
          ],
          layoutBuilder: (BuildContext ctx, RoutingData routingData, Widget page) {
            return _PackageLandingViewLayout<TLandingThemeBase>(
              page: page,
              routingData: routingData,
              themes: bootstrapTheming(),
              routingGraph: contextGraphs.$1,
            );
          },
        ),
      ],
    );
  }

  @override
  Widget bootstrapBuild(BuildContext context, Widget? app) {
    PackageLandingThemeBase theme = ThemingUtils.get(context);

    return super.bootstrapBuild(
      context,
      ColoredBox(
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
      ),
    );
  }

  (_Graph<TLandingThemeBase> navigationGraph, _Graph<TLandingThemeBase> packageEntriesGraph, List<IRoutingGraphData> routes) composeContextGraphs(NavigationState entriesLayoutKey, NavigationState navigationLayoutKey) {
    _Graph<TLandingThemeBase> navigationGraph = <RouteData, IPackageLandingEntry<TLandingThemeBase>>{};
    _Graph<TLandingThemeBase> pakcageEntriesGraph = <RouteData, IPackageLandingEntry<TLandingThemeBase>>{};

    List<IRoutingGraphData> routes = <IRoutingGraphData>[];
    for (IPackageLandingEntry<TLandingThemeBase> landingEntry in packageEntries) {
      String entryRoutePath = landingEntry.name.toLowerCase().replaceAll(' ', '_');

      RouteData entryRoute = RouteData(entryRoutePath, name: landingEntry.name);

      navigationGraph[entryRoute] = landingEntry;
      pakcageEntriesGraph[entryRoute] = landingEntry;

      void nestedRoutesIterator(List<IRoutingGraphData> nestedRoutes) {
        for (IRoutingGraphData nestedRoute in nestedRoutes) {
          if (nestedRoute is RoutingGraphNodeDataBase) {
            pakcageEntriesGraph[nestedRoute.route] = landingEntry;
          }

          nestedRoutesIterator(nestedRoute.routes);
        }
      }

      List<IRoutingGraphData> nestdRoutes = landingEntry.composeRoutes(navigationLayoutKey, entriesLayoutKey);
      routes.add(
        RoutingGraphNode(
          entryRoute,
          routes: nestdRoutes,
          pageBuilder: (BuildContext ctx, RoutingData routeData) => landingEntry,
        ),
      );
      nestedRoutesIterator(
        landingEntry.composeRoutes(navigationLayoutKey, entriesLayoutKey),
      );
    }

    return (navigationGraph, pakcageEntriesGraph, routes);
  }
}
