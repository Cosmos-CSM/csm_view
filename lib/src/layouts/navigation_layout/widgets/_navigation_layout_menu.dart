part of '../navigation_layout.dart';

/// Draws the [NavigationLayout] menu pages router.
final class _NavigationLayoutMenu extends StatefulWidget {
  /// Route data.
  final RouteData routeData;

  /// Navigation nodes.
  final List<INavigationLayoutNode> navigationNodes;

  /// Creates a new instance.
  const _NavigationLayoutMenu({
    required this.routeData,
    required this.navigationNodes,
  });

  @override
  State<_NavigationLayoutMenu> createState() => _NavigationLayoutMenuState();
}

/// State class for [_NavigationLayoutMenu]
final class _NavigationLayoutMenuState extends State<_NavigationLayoutMenu> {
  @override
  Widget build(BuildContext context) {
    IRouter router = InjectorUtils.get();

    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 16,
      ),
      child: SingleChildScrollView(
        child: Column(
          spacing: 8,
          children: <Widget>[
            for (int i = 0; i < widget.navigationNodes.length; i++)
              _NavigationLayoutMenuButton(
                navigationNode: widget.navigationNodes[i],
                isSelected: router.getAbsolutePath(widget.routeData).contains(router.getAbsolutePath(widget.navigationNodes[i].routeData)),
              ),
          ],
        ),
      ),
    );
  }
}
