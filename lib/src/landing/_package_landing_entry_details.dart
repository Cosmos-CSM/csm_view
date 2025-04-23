part of 'package_landing.dart';

/// Internal fragment for [PackageLanding] view composition that displays only the details for the component selected.
final class _PackageLandingEntryDetails extends StatelessWidget {
  final PackageLandingEntry entry;

  const _PackageLandingEntryDetails(this.entry);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          entry.name,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 17,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            top: 4,
          ),
          child: entry.description,
        )
      ],
    );
  }
}
