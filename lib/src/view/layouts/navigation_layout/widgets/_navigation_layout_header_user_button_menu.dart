part of '../navigation_layout.dart';

/// {widget} class.
///
/// Draws the [_NavigationLayoutHeader] user button to interact with the user information and options.
final class _NavigationLayoutHeaderUserButtonMenu extends StatelessWidget with ThemingMixin {
  /// User information.
  final INavigationLayoutHeaderUserData user;

  /// Creates a new [_NavigationLayoutHeaderUserButtonMenu] instance.
  const _NavigationLayoutHeaderUserButtonMenu(this.user);

  @override
  Widget build(BuildContext context) {
    final ThemingData pageTheming = getTheme<IThemeData>(context).page;

    return ColoredBox(
      color: pageTheming.back,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 12,
            horizontal: 4,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              // --> User information
              Row(
                children: <Widget>[
                  // User icon
                  Expanded(
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: Icon(
                          color: pageTheming.fore,
                          Icons.person_outline,
                        ),
                      ),
                    ),
                  ),

                  // Contact data
                  Expanded(
                    flex: 3,
                    child: Column(
                      spacing: 4,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        // Name
                        Text(
                          user.fullName,
                          maxLines: 3,
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                          ),
                        ),

                        /// E-Mail information
                        Tooltip(
                          message: user.email,
                          child: Text(
                            user.email,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
