/// Model contract to define information needed to correctly build [NavigationLayout] header user button.
abstract interface class NavigationLayoutHeaderUserI {
  /// User pile name.
  final String name;

  /// User last name.
  final String lastName;

  /// User email information.
  final String email;

  /// User full name.
  String get fullName;

  /// User full name monogram.
  String get monogram;

  /// Creates a new [NavigationLayoutHeaderUserI] instance.
  const NavigationLayoutHeaderUserI(this.name, this.lastName, this.email);
}

/// Data {model} implementation to store user information required for [NavigationLayout] header user button.
final class NavigationLayoutHeaderUser implements NavigationLayoutHeaderUserI {
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

  /// Creates a new [NavigationLayoutHeaderUser] instance.
  const NavigationLayoutHeaderUser({
    required this.name,
    required this.email,
    required this.lastName,
  });
}
