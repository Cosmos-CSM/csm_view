part of '../navigation_layout.dart';

/// Draws a [NavigationLayout] menu button for application navigation.
final class _NavigationLayoutMenuButton extends StatelessWidget {
  /// Navigation layout node data.
  final INavigationLayoutNode navigationNode;

  /// Creates a new instance.
  const _NavigationLayoutMenuButton({
    required this.navigationNode,
  });

  @override
  Widget build(BuildContext context) {
    return PointerArea(
      cursor: SystemMouseCursors.click,
      onClick: () {
        IRouter router = InjectorUtils.get();

        router.go(context, navigationNode.routeData);
      },
      onHover: (bool hover) {},
      child: ColoredBox(
        color: Colors.blueAccent,
        child: SizedBox(
          height: 35,
          width: double.maxFinite,
          child: Row(
            spacing: 10,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              /// Selected Entry mark.
              if (true)
                ColoredBox(
                  color: Colors.green,
                  child: SizedBox(
                    width: 4,
                    height: double.maxFinite,
                  ),
                ),

              if (navigationNode.icon != null)
                Icon(
                  navigationNode.icon,
                  size: 20,
                  color: Colors.white,
                ),
              Text(
                navigationNode.title,
                style: TextStyle(
                  height: 1.0,
                  color: Colors.white,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
