import 'package:csm_view/csm_view.dart';

/// Data {model} implementation to store user information required for [NavigationLayout] header user button.
final class NavigatonLayoutHeaderUserData implements INavigationLayoutHeaderUserData {
  /// User pile name.
  @override
  final String name;

  /// User last name.
  @override
  final String lastName;

  /// User email information.
  @override
  final String email;

  @override
  String get fullName => '$name $lastName';

  /// User full name monogram.
  @override
  String get monogram => '${name[0].toUpperCase()}${lastName[0].toUpperCase()}';

  /// Creates a new [NavigatonLayoutHeaderUserData] instance.
  const NavigatonLayoutHeaderUserData({
    required this.name,
    required this.email,
    required this.lastName,
  });
}
