part of '../package_landing.dart';

///
final class _PackageLandingLayoutMenu<T extends PackageLandingThemeB> extends StatelessWidget {
  final double menuWidth;

  final Route currentRoute;

  final Map<PackageLandingEntryI<T>, Route> routingThree;

  const _PackageLandingLayoutMenu({
    required this.menuWidth,
    required this.routingThree,
    required this.currentRoute,
  });

  @override
  Widget build(BuildContext context) {
    final PackageLandingThemeB theme = Theming.get();
    final Router router = Injector.get();

    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 16,
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        primary: false,
        controller: ScrollController(),
        child: Column(
          spacing: 8,
          children: <Widget>[
            for (MapEntry<PackageLandingEntryI<T>, Route> routingLeaf
                in routingThree.entries) ...<Widget>[
              Builder(
                builder: (BuildContext context) {
                  final bool isSelected = currentRoute == routingLeaf.value;
                  final SimpleTheming buttonTheme =
                      isSelected ? theme.pageTheming : theme.headerTheming;

                  return Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 8,
                    ),
                    child: PointerArea(
                      cursor: SystemMouseCursors.click,
                      child: SizedBox(
                        width: menuWidth - 16,
                        child: TextButton(
                          style: ButtonStyle(
                            shape: WidgetStateOutlinedBorder.resolveWith(
                              (Set<WidgetState> states) {
                                return RoundedRectangleBorder();
                              },
                            ),
                            backgroundColor: WidgetStateColor.resolveWith(
                              (Set<WidgetState> states) {
                                return buttonTheme.back.withAlpha(200);
                              },
                            ),
                          ),
                          onPressed: isSelected
                              ? null
                              : () {
                                  router.go(routingLeaf.value);
                                },
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Text(
                              routingLeaf.key.name,
                              textAlign: TextAlign.start,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: buttonTheme.fore,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              )
            ],
            Container(
              color: Colors.red,
              height: 1000,
              width: 100,
            ),
          ],
        ),
      ),
    );
  }
}
