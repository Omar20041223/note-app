import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ForceUpdateView extends StatelessWidget {
  const ForceUpdateView({super.key});

  Future<void> _launchStore(BuildContext context) async {
    final Uri url = Uri.parse(
      Theme.of(context).platform == TargetPlatform.android
          ? 'https://play.google.com/store/apps/details?id=com.example.note_app'
          : 'https://apps.apple.com/app/idYOUR_APP_ID',
    );
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.system_update, size: 80, color: Colors.orange),
              const SizedBox(height: 24),
              Text(
                'A new version of the app is available.\nPlease update to continue.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 32),
              ElevatedButton.icon(
                icon: Icon(Icons.open_in_new),
                label: Text('Update Now'),
                onPressed: () => _launchStore(context),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 32, vertical: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
