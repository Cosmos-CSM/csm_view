part of 'package_landing.dart';

/// Internal view fragment for [PackageLanding] view composition that only displays the running device information.
final class _PackageLandingDeviceDetails extends StatelessWidget {
  final String systemVersion;

  const _PackageLandingDeviceDetails(this.systemVersion);

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: TextStyle(
          fontSize: 16,
          height: 1.5,
        ),
        children: <InlineSpan>[
          TextSpan(
            text: 'Device information: \n',
          ),

          // --> Platform line
          TextSpan(
            text: 'Platform:',
          ),
          TextSpan(
            text: ' ${Domain.context}\n',
            style: TextStyle(
              color: Domain.context.color,
            ),
          ),

          // --> Device system.
          TextSpan(
            text: 'System:',
          ),
          TextSpan(
            text: ' ${defaultTargetPlatform.name.toStartUpperCase()} ( $systemVersion )',
            style: TextStyle(
              color: Colors.blueAccent,
            ),
          ),
        ],
      ),
    );
  }
}
