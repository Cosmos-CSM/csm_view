/// Model contract to define information needed to correctly build [NavigationLayout] header user button.
abstract interface class INavigationLayoutHeaderUserData {
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

  /// Creates a new [INavigationLayoutHeaderUserData] instance.
  const INavigationLayoutHeaderUserData(this.name, this.lastName, this.email);
}
