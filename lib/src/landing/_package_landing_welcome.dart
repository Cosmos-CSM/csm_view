part of 'package_landing.dart';

///
final class _PackageLandingWelcome extends PageB {
  /// Creates a new [_PackageLandingWelcome] instance.
  const _PackageLandingWelcome();

  @override
  Widget compose(BuildContext ctx, Size window) {
    return Center(
      child: Text(
        'Welcome to your package playground!',
      ),
    );
  }
}
