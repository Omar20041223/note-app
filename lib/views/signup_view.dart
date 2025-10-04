import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:note_app/helpers/routes.dart';
import 'package:note_app/views/widgets/auth/sign_up_widgets/sign_up_body.dart';
import '../helpers/app_colors.dart';
import '../helpers/app_styles.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SignUpBody(),
    );
  }
}
