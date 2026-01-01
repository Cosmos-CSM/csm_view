part of '../navigation_layout.dart';

/// {widget} class.
///
/// Draws the [_NavigationLayoutHeader] user button to interact with the user information and options.
final class _NavigationLayoutHeaderUserButtonMenu extends StatelessWidget with ThemingMixin {
  /// User information.
  final INavigationLayoutHeaderUserData userData;

  /// Creates a new [_NavigationLayoutHeaderUserButtonMenu] instance.
  const _NavigationLayoutHeaderUserButtonMenu(this.userData);

  @override
  Widget build(BuildContext context) {
    final ThemingData pageTheme = getTheme<IThemeData>(context).page;

    return ColoredBox(
      color: pageTheme.back,
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
                          color: pageTheme.fore,
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
                          userData.fullName,
                          maxLines: 3,
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                          ),
                        ),

                        /// E-Mail information
                        Tooltip(
                          message: userData.email,
                          child: Text(
                            userData.email,
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
