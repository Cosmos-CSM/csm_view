import 'package:csm_view/csm_view.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

part 'private/csm_package_landing_device.dart';
part 'private/csm_package_landing_entry_details.dart';

/// A Package Landing full application manager for View packages based on [CSMView].
///
/// Gives a set of tools to easyly display the whle package component library and brief descriptions,
/// making them interactive and testable visibly.
final class CSMPackageLanding extends StatefulWidget {
  /// The title of the package.
  final String title;

  /// The default landing view.
  final CSMPackageLandingEntry? landingEntry;

  /// The available package view entries at the drawer.
  final List<CSMPackageLandingEntry> entries;

  /// Creates a new [CSMPackageLanding] instance object.
  const CSMPackageLanding({
    super.key,
    this.landingEntry,
    this.entries = const <CSMPackageLandingEntry>[],
    required this.title,
  });

  @override
  State<CSMPackageLanding> createState() => _CSMPackageLandingState();
}

class _CSMPackageLandingState extends State<CSMPackageLanding> {
  late ValueNotifier<CSMPackageLandingEntry> currentEntry;
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

    currentEntry = ValueNotifier<CSMPackageLandingEntry>(
      widget.landingEntry ??
          CSMPackageLandingEntry(
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
              child: CSMSpacingColumn(
                spacing: 8,
                includeStart: true,
                children: <Widget>[
                  for (CSMPackageLandingEntry entry in widget.entries) ...<Widget>[
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
              child: ValueListenableBuilder<CSMPackageLandingEntry>(
                valueListenable: currentEntry,
                builder: (BuildContext context, CSMPackageLandingEntry entry, Widget? child) {
                  return Wrap(
                    alignment: WrapAlignment.spaceEvenly,
                    runSpacing: 16,
                    spacing: 16,
                    verticalDirection: VerticalDirection.up,
                    children: <Widget>[
                      if (entry.name.isNotEmpty) _CSMPackageLandingEntryDetails(entry),
                      _CSMPackageLandingDevice(systemVersion),
                    ],
                  );
                },
              ),
            ),

            // --> Displayable component zone
            Expanded(
              child: ValueListenableBuilder<CSMPackageLandingEntry>(
                valueListenable: currentEntry,
                builder: (BuildContext context, CSMPackageLandingEntry value, Widget? child) {
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
