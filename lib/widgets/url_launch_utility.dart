import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../utilities/app_strings.dart';

void launchURL(BuildContext context, String url) async {
  final Uri uri = Uri.parse(url);

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text('${AppStrings.opening}: $url')),
  );

  final canLaunch = await canLaunchUrl(uri);
  if (canLaunch) {
    await launchUrl(uri, mode: LaunchMode.externalApplication); // opens in browser or native app
  } else {
    // Use WidgetsBinding to ensure context is still valid after async gap
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text(AppStrings.cannotOpenURL)),
        );
      }
    });
  }
}
