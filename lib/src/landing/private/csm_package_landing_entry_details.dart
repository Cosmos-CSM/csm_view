part of '../csm_package_landing.dart';

/// Internal fragment for [CSMPackageLanding] view composition that displays only the details for the component selected.
final class _CSMPackageLandingEntryDetails extends StatelessWidget {
  final CSMPackageLandingEntry entry;

  const _CSMPackageLandingEntryDetails(this.entry);

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
