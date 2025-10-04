import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:note_app/helpers/app_router.dart';
import 'package:note_app/helpers/extensions.dart';
import 'package:note_app/helpers/validator.dart';
import 'package:note_app/models/auth/sign_up_request.dart';
import 'package:note_app/services/auth_service.dart';
import 'package:note_app/views/widgets/auth/auth_field.dart';
import '../../../../helpers/app_colors.dart';
import '../../../../helpers/routes.dart';
import '../../common_widgets/custom_button.dart';

class SignUpFields extends StatefulWidget {
  const SignUpFields({super.key});

  @override
  State<SignUpFields> createState() => _SignUpFieldsState();
}

class _SignUpFieldsState extends State<SignUpFields> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final AuthService _authService = AuthService();

  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController fullNameController;

  bool isLoading = false;

  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    fullNameController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    fullNameController.dispose();
    super.dispose();
  }

  Future<void> _handleSignUp(BuildContext context) async {
    if (!formKey.currentState!.validate()) return;

    setState(() => isLoading = true);

    try {
      final user = await _authService.signUpWithEmail(
        signUpRequest: SignUpRequest(
          fullName: fullNameController.text.trim(),
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        ),
      );

      if (user != null) {
        context.showSnackBar(text: 'Welcome ${fullNameController.text} 🎉');
        GoRouter.of(context).pushReplacement(Routes.createNote); // ✅ navigate back to login after signup
      }
    } catch (e) {
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
            title: 'Full Name',
            controller: fullNameController,
            validator: (fullName) => Validator.userNameValidator(fullName),
          ),
          const SizedBox(height: 16),
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
            text: isLoading ? 'Loading...' : 'Sign Up',
            buttonColor: AppColors.lightText,
            onTap: isLoading ? null : () => _handleSignUp(context),
          ),
        ],
      ),
    );
  }
}
