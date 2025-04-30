part of 'view_root.dart';

final class _ViewRootSize extends StatelessWidget {
  const _ViewRootSize();

  @override
  Widget build(BuildContext context) {
    final Size frameSize = MediaQuery.sizeOf(context);
    final ThemeB theme = Theming.get();

    return Text(
      frameSize.toString(),
      style: TextStyle(
        fontSize: 16,
        backgroundColor: Colors.transparent,
        decoration: TextDecoration.none,
        color: theme.frame,
        fontStyle: FontStyle.italic,
      ),
    );
  }
}
