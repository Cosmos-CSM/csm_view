part of '../navigation_layout.dart';

/// Draws a [NavigationLayout] menu button for application navigation.
final class _NavigationLayoutMenuButton extends StatefulWidget {
  /// Whether the current button must be selected.
  final bool isSelected;

  /// Navigation layout node data.
  final INavigationLayoutNode navigationNode;

  /// Creates a new instance.
  const _NavigationLayoutMenuButton({
    required this.isSelected,
    required this.navigationNode,
  });

  @override
  State<_NavigationLayoutMenuButton> createState() => _NavigationLayoutMenuButtonState();
}

/// State class for [_NavigationLayoutMenuButton].
final class _NavigationLayoutMenuButtonState extends State<_NavigationLayoutMenuButton> with ThemingStateMixin<_NavigationLayoutMenuButton> {
  /// Wheter the button is currently hovered.
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    ThemingData themeData = getTheme<INavigationLayoutThemeData>().navigationLayout;

    return PointerArea(
      cursor: SystemMouseCursors.click,
      onClick: () {
        if (widget.isSelected) return;

        IRouter router = InjectorUtils.get();

        router.go(context, widget.navigationNode.routeData);
      },
      onHover: (bool hover) {
        if (widget.isSelected) return;

        setState(() {
          isHovered = hover;
        });
      },
      child: ColoredBox(
        color: widget.isSelected
            ? themeData.back.withAlpha(205)
            : isHovered
                ? themeData.back.withAlpha(127)
                : themeData.back,
        child: Padding(
          padding: const EdgeInsets.only(
            left: 12,
          ),
          child: SizedBox(
            height: 35,
            width: double.maxFinite,
            child: Row(
              spacing: 10,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                /// Selected Entry mark.
                if (widget.isSelected)
                  ColoredBox(
                    color: themeData.accent,
                    child: SizedBox(
                      width: 4,
                      height: double.maxFinite,
                    ),
                  ),

                if (widget.navigationNode.icon != null)
                  Icon(
                    widget.navigationNode.icon,
                    size: 20,
                    color: Colors.white,
                  ),
                Text(
                  widget.navigationNode.title,
                  style: TextStyle(
                    height: 1.0,
                    color: themeData.fore,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
