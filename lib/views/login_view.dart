import 'package:flutter/material.dart';
import 'package:note_app/views/widgets/auth/login_widgets/login_body.dart';


class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: LoginBody(),
    );
  }
}
