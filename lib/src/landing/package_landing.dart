import 'package:csm_view/csm_view.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' hide Route, Router;

part '_package_landing_device_details.dart';
part '_package_landing_entry_details.dart';
part '_package_landing_welcome.dart';
part '_package_landing_router.dart';
part '_package_landing_layout.dart';

/// [Widget] class for [PackagePlayground].
/// 
/// 
/// Provides a complex detailed view for a [Package] development example. Allowing to interact in user-time with the objects
/// created in the package and test them manually, also works to create a documentation portal for developers internally and can be published.
final class PackagePlayground extends StatelessWidget {
  
  /// Package name.
  final String name;

  /// Package playground entry.
  final List<PackageLandingEntryI> landingEntries;

  /// Createsa a new [PackagePlayground] instance.
  const PackagePlayground({
    super.key,
    required this.name,
    required this.landingEntries,
  });

  /// Calculates a simulated internal Route Tree based on the [landingEntries] configured, to store
  /// the reference for the [Route] object instances as they're needed for [Router] handling.
  Map<PackageLandingEntryI, Route> calculateRouteTree() {
    final Map<PackageLandingEntryI, Route> treeCache = <PackageLandingEntryI, Route>{};

    for (PackageLandingEntryI landingEntry in landingEntries) {
      final Route entryRoute = Route(landingEntry.name);
      treeCache[landingEntry] = entryRoute;
    }

    return treeCache;
  }

  @override
  Widget build(BuildContext context) {
    final Map<PackageLandingEntryI, Route> routingTree = calculateRouteTree();

    return ViewRoot<PackageLandingThemeB>(
      defaultTheme: PackageLandingThemeLight(),
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
              for (MapEntry<PackageLandingEntryI, Route> routingLeaf in routingTree.entries) ...<RouteB>[
                RouteNode(
                  routingLeaf.value,
                  pageBuilder: (_, __) => routingLeaf.key,
                ),
              ],
            ],
            layoutBuilder: (BuildContext ctx, RouteData routeData, Widget page) {
              return _PackageLandingLayout(
                page: page,
              );
            },
          ),
        ],
      ),
      home: Title(
        color: Colors.black,
        title: name,
        child: Center(
          child: Text('Welcome to CSM View package landing!'),
        ),
      ),
    );
  }  
}
