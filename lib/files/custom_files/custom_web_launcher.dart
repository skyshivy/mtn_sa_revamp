import 'package:url_launcher/url_launcher.dart';

Future<void> customWebLauncher(String url) async {
  final Uri localUrl = Uri.parse(url);
  if (!await launchUrl(localUrl, webOnlyWindowName: '')) {
    //if (!await launchUrl(localUrl, webOnlyWindowName: '_self')) { will open in same window
    throw Exception('Could not launch $localUrl');
  }
}
