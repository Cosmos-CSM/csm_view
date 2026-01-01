part of '../navigation_layout.dart';

/// {widget} class.
///
/// Draws a button to access User information and scoped options.
final class _NavigationHeaderUserButton extends StatefulWidget {
  /// User information.
  final INavigationLayoutHeaderUserData userData;

  /// Creates a new [_NavigationHeaderUserButton] instance.
  const _NavigationHeaderUserButton({
    required this.userData,
  });

  @override
  State<_NavigationHeaderUserButton> createState() => _NavigationHeaderUserButtonState();
}

/// {state} class.
///
/// Handles the [State] for [_NavigationHeaderUserButton].
final class _NavigationHeaderUserButtonState extends State<_NavigationHeaderUserButton> {
  /// Constants default displayed user menu drawer width.
  static const double _userButtonMenuWidth = 250;

  /// Global reference for the [Widget] that represents the User Button.
  final GlobalKey userButtonKey = GlobalKey();

  /// Overlay controller for the User Menu options drawer display.
  final OverlayPortalController _overlayPortalCtrlr = OverlayPortalController();

  /// {dep} Reference to the application [ThemeManagerI].
  late final ThemeManager themeManager = ThemeManager.of(context);

  /// {ref} Theming reference for effect subscription / disposition.
  final UniqueKey themeEffectRef = UniqueKey();

  /// {theming} Simple theming information for [NavigationLayout].
  late ThemingData navigationLayoutTheming;

  /// {state} whether the user button is being hovered.
  bool isHover = false;

  /// {event} triggered when the User Button [Widget] is being hover in / out.
  ///
  /// [isOn] whether the hover is in(true) or out(false)
  void onHover(bool isOn) {
    setState(() {
      isHover = isOn;
    });
  }

  @override
  void initState() {
    super.initState();

    navigationLayoutTheming = themeManager.castData<INavigationLayoutThemeData>().navigationLayout;
  }

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: "User Account Options",
      child: PointerArea(
        cursor: SystemMouseCursors.click,
        onHover: onHover,
        child: OverlayPortal(
          controller: _overlayPortalCtrlr,
          overlayChildBuilder: (_) {
            RenderBox? renderBox = userButtonKey.currentContext?.findRenderObject() as RenderBox?;

            final Offset buttonOffset = renderBox?.localToGlobal(Offset.zero) ?? Offset.zero;
            final Size buttonSize = renderBox?.size ?? Size.zero;
            final Size globalSize = MediaQuery.sizeOf(context);

            return Positioned(
              top: (buttonOffset.dy),
              right: (globalSize.width) - (buttonOffset.dx + buttonSize.width),
              child: TapRegion(
                consumeOutsideTaps: false,
                onTapOutside: (_) {
                  if (!isHover) {
                    _overlayPortalCtrlr.hide();
                  }
                },
                child: SizedBox(
                  width: _userButtonMenuWidth,
                  child: _NavigationLayoutHeaderUserButtonMenu(widget.userData),
                ),
              ),
            );
          },
          child: PointerArea(
            cursor: SystemMouseCursors.click,
            onHover: (_) => _overlayPortalCtrlr.toggle(),
            child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints boxConstraints) {
                Color backgroundColor = navigationLayoutTheming.fore;
                if (isHover) {
                  backgroundColor = backgroundColor.withValues(
                    alpha: .8,
                  );
                }

                return AnimatedContainer(
                  key: userButtonKey,
                  duration: 200.miliseconds,
                  width: boxConstraints.maxHeight - 14,
                  decoration: BoxDecoration(
                    color: backgroundColor,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    // Main header user button content.
                    child: Text(
                      widget.userData.monogram,
                      style: TextStyle(
                        color: navigationLayoutTheming.back,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
