import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:note_app/helpers/routes.dart';
import 'package:note_app/services/auth_service.dart';
import '../../../helpers/app_styles.dart';

AppBar customAppBar({
  required final String title,
  final VoidCallback? onEdit,
  required BuildContext context, // 👈 add context to use dialogs/navigation
}) {
  final AuthService _authService = AuthService();

  return AppBar(
    backgroundColor: Colors.white,
    title: Text(title, style: AppStyles.font18blackTextW700),
    centerTitle: true,
    actions: onEdit != null
        ? [
      IconButton(onPressed: onEdit, icon: const Icon(Icons.edit)),
    ]
        : [
      // 🔹 Logout Button
      IconButton(
        icon: const Icon(Icons.logout),
        onPressed: () async {
          await _authService.logout();
          // Optionally navigate to login page
          GoRouter.of(context).pushReplacement(Routes.login);
        },
      ),
      // 🔹 Delete Account Button
      IconButton(
        icon: const Icon(Icons.delete),
        onPressed: () async {
          final confirm = await showDialog<bool>(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Delete Account'),
              content: const Text('Are you sure you want to delete your account? This cannot be undone.'),
              actions: [
                TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancel')),
                TextButton(onPressed: () => Navigator.pop(context, true), child: const Text('Delete')),
              ],
            ),
          );

          if (confirm == true) {
            try {
              await FirebaseAuth.instance.currentUser?.delete();
              // Also log out after deletion
              await _authService.logout();
              GoRouter.of(context).pushReplacement(Routes.login);
            } on FirebaseAuthException catch (e) {
              if (e.code == 'requires-recent-login') {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Please log in again before deleting your account.')),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Error: ${e.message}')),
                );
              }
            }
          }
        },
      ),
    ],
  );
}
