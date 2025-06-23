part of '../package_landing.dart';

final class _PackageLandingWelcomeEntry<T extends LandingThemeB> extends StatelessWidget {
  final PackageLandingEntryI<T> landingEntry;

  final Route route;

  const _PackageLandingWelcomeEntry({
    super.key,
    required this.route,
    required this.landingEntry,
  });

  @override
  Widget build(BuildContext context) {
    final T theme = Theming.get(context);
    final Router router = Injector.get();

    return PointerArea(
      cursor: SystemMouseCursors.click,
      onClick: () {
        router.go(route);
      },
      child: Card.filled(
        elevation: 8,
        color: theme.welcomeCardTheming.back,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: landingEntry.image == null
                    ? Placeholder(
                        color: Colors.red,
                        strokeWidth: 2,
                        child: Center(
                          child: Text(
                            'No image provider set',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      )
                    : Image(
                        image: landingEntry.image!,
                      ),
              ),
              Expanded(
                flex: 2,
                child: Column(
                  children: <Widget>[
                    // --> Entry card title
                    Tooltip(
                      message: landingEntry.name,
                      child: Text(
                        landingEntry.name,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white70,
                          fontWeight: FontWeight.w700,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(4),
                          child: Text.rich(
                            landingEntry.description(theme, theme.welcomeCardTheming.fore),
                            style: TextStyle(
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
