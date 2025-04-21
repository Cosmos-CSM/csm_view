import 'package:csm_view/csm_view.dart';
import 'package:device_info_plus/device_info_plus.dart' show DeviceInfoPlugin;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

part '_package_landing_device_details.dart';
part '_package_landing_entry_details.dart';

/// A Package Landing full application manager for View packages based on [CSMView].
///
/// Gives a set of tools to easyly display the whle package component library and brief descriptions,
/// making them interactive and testable visibly.
final class PackageLanding extends StatefulWidget {
  /// The title of the package.
  final String title;

  /// The default landing view.
  final PackageLandingEntry? landingEntry;

  /// The available package view entries at the drawer.
  final List<PackageLandingEntry> entries;

  /// Creates a new [PackageLanding] instance object.
  const PackageLanding({
    super.key,
    this.landingEntry,
    this.entries = const <PackageLandingEntry>[],
    required this.title,
  });

  @override
  State<PackageLanding> createState() => _PackageLandingState();
}

class _PackageLandingState extends State<PackageLanding> {
  late ValueNotifier<PackageLandingEntry> currentEntry;
  String systemVersion = '---';

  @override
  void initState() {
    super.initState();
    // --> Getting device info to display system version.
    DeviceInfoPlugin().deviceInfo.then(
      (BaseDeviceInfo deviceInfo) {
        setState(
          () {
            if (deviceInfo is WebBrowserInfo) {
              systemVersion = deviceInfo.appVersion?.split(' ').reversed.elementAt(1) ?? systemVersion;
            } else if (deviceInfo is LinuxDeviceInfo) {
              systemVersion = deviceInfo.version ?? systemVersion;
            } else if (deviceInfo is WindowsDeviceInfo) {
              systemVersion = deviceInfo.displayVersion;
            } else if (deviceInfo is AndroidDeviceInfo) {
              systemVersion = deviceInfo.version.incremental;
            } else if (deviceInfo is IosDeviceInfo) {
              systemVersion = deviceInfo.systemVersion;
            }
          },
        );
      },
    );

    currentEntry = ValueNotifier<PackageLandingEntry>(
      widget.landingEntry ??
          PackageLandingEntry(
            name: '',
            description: RichText(
              text: TextSpan(),
            ),
            composeLanding: (BuildContext ctx) {
              return SizedBox();
            },
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          backgroundColor: Colors.blueGrey,
          foregroundColor: Colors.white,
          title: Center(
            child: Text('${widget.title} Landing'),
          ),
        ),
        drawer: ColoredBox(
          color: Colors.blueGrey,
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: 500,
            ),
            child: SizedBox(
              width: MediaQuery.sizeOf(context).width * .65,
              height: double.maxFinite,
              child: Column(
                spacing: 8,
                children: <Widget>[
                  for (PackageLandingEntry entry in widget.entries) ...<Widget>[
                    SizedBox(
                      width: double.infinity,
                      child: TextButton(
                        onPressed: () {
                          currentEntry.value = entry;
                          scaffoldKey.currentState?.closeDrawer();
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text(
                            entry.name,
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ]
                ],
              ),
            ),
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              width: double.maxFinite,
              child: ValueListenableBuilder<PackageLandingEntry>(
                valueListenable: currentEntry,
                builder: (BuildContext context, PackageLandingEntry entry, Widget? child) {
                  return Wrap(
                    alignment: WrapAlignment.spaceEvenly,
                    runSpacing: 16,
                    spacing: 16,
                    verticalDirection: VerticalDirection.up,
                    children: <Widget>[
                      if (entry.name.isNotEmpty) _PackageLandingEntryDetails(entry),
                      _PackageLandingDeviceDetails(systemVersion),
                    ],
                  );
                },
              ),
            ),

            // --> Displayable component zone
            Expanded(
              child: ValueListenableBuilder<PackageLandingEntry>(
                valueListenable: currentEntry,
                builder: (BuildContext context, PackageLandingEntry value, Widget? child) {
                  final String displayedTitle = value.name.isNotEmpty ? value.name : 'CSM View Landing';

                  return Title(
                    color: Colors.black,
                    title: displayedTitle,
                    child: Expanded(
                      child: SizedBox(
                        child: value.composeLanding(context),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
