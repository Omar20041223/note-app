import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:note_app/helpers/extensions.dart';
import 'package:note_app/helpers/validator.dart';
import 'package:note_app/models/auth/login_request.dart';
import 'package:note_app/services/auth_service.dart';
import 'package:note_app/views/widgets/auth/auth_field.dart';
import 'package:note_app/views/widgets/common_widgets/custom_button.dart';
import '../../../../helpers/app_colors.dart';
import '../../../../helpers/routes.dart';

class LoginFields extends StatefulWidget {
  const LoginFields({super.key});

  @override
  State<LoginFields> createState() => _LoginFieldsState();
}

class _LoginFieldsState extends State<LoginFields> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final AuthService _authService = AuthService();

  late TextEditingController emailController;
  late TextEditingController passwordController;

  bool isLoading = false;

  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin(BuildContext context) async {
    if (!formKey.currentState!.validate()) return;

    setState(() => isLoading = true);

    try {
      final user = await _authService.loginWithEmail(
        loginRequest: LoginRequest(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        ),
      );

      if (user != null) {
        context.showSnackBar(text: 'Login Successful, Hello ${user.displayName}'); // ✅ Show success message
        GoRouter.of(context).pushReplacement(Routes.createNote); // 🚀 Navigate to Create Note screen
      }
    } catch (e) {
      // ❌ Show error message
      context.showSnackBar(text: e.toString());
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          AuthField(
            title: 'Email',
            controller: emailController,
            validator: (email) => Validator.emailValidator(email),
          ),
          const SizedBox(height: 16),
          AuthField(
            title: 'Password',
            isPasswordField: true,
            controller: passwordController,
            validator: (password) => Validator.passwordValidator(password),
          ),
          const SizedBox(height: 24),
          CustomButton(
            text: isLoading ? 'Loading...' : 'Login',
            buttonColor: AppColors.lightText,
            onTap: isLoading ? null : () => _handleLogin(context), // ✅ fixed line
          ),
        ],
      ),
    );
  }
}
