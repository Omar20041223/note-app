import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:note_app/services/remote_config_service.dart';
import 'package:note_app/views/create_note_view.dart';
import 'package:note_app/views/login_view.dart';
import 'package:note_app/views/force_update_view.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    final config = RemoteConfigService.instance;
    return FutureBuilder<bool>(
      future: config.isForceUpdateRequired,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        if (snapshot.hasData && snapshot.data == true) {
          return const ForceUpdateView();
        }
        // No force update required, continue with auth logic
        return StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, authSnapshot) {
            if (authSnapshot.connectionState == ConnectionState.waiting) {
              return const Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            } else if (FirebaseAuth.instance.currentUser != null) {
              return const CreateNoteView();
            } else {
              return const LoginView();
            }
          },
        );
      },
    );
  }
}
