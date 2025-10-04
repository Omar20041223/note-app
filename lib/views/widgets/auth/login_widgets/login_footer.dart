import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:note_app/helpers/app_styles.dart';
import 'package:note_app/helpers/routes.dart';
import 'package:note_app/services/auth_service.dart';
import 'package:note_app/helpers/extensions.dart'; // for showSnackBar

class LoginFooter extends StatefulWidget {
  const LoginFooter({super.key});

  @override
  State<LoginFooter> createState() => _LoginFooterState();
}

class _LoginFooterState extends State<LoginFooter> {
  final AuthService _authService = AuthService();
  bool isGoogleLoading = false;

  Future<void> _handleGoogleLogin(BuildContext context) async {
    setState(() => isGoogleLoading = true);
    try {
      final user = await _authService.signInWithGoogle();

      if (user != null) {
        context.showSnackBar(text: 'Welcome, ${user.displayName ?? "User"}');
        GoRouter.of(context).pushReplacement(Routes.createNote);
      } else {
        context.showSnackBar(text: 'Google Sign-In cancelled');
      }
    } catch (e) {
      context.showSnackBar(text: 'Error: $e');
    } finally {
      setState(() => isGoogleLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 30),
        // 🔹 Google Sign-In Button
        GestureDetector(
          onTap: isGoogleLoading ? null : () => _handleGoogleLogin(context),
          child: Container(
            height: 50,
            width: double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: 40),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey.shade300),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 5,
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images/google_logo.png', height: 24), // 🟢 Add your Google logo asset
                const SizedBox(width: 10),
                Text(
                  isGoogleLoading ? 'Signing in...' : 'Continue with Google',
                  style: AppStyles.font16blackTextW400.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Don’t have an account? ", style: AppStyles.font16blackTextW400),
            GestureDetector(
              onTap: () => GoRouter.of(context).push(Routes.signUp),
              child: Text(
                'Sign Up',
                style: AppStyles.font16lightTextW400.copyWith(fontWeight: FontWeight.w700),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
