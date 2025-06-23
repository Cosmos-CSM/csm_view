part of 'view_root.dart';

final class _ViewRootSize extends StatelessWidget {
  const _ViewRootSize();

  @override
  Widget build(BuildContext context) {
    Size frameSize = MediaQuery.sizeOf(context);
    ThemeDataB themeData = Theming.get(context);

    return Text(
      frameSize.toString(),
      style: TextStyle(
        fontSize: 16,
        backgroundColor: Colors.transparent,
        decoration: TextDecoration.none,
        color: themeData.frame,
        fontStyle: FontStyle.italic,
      ),
    );
  }
}
