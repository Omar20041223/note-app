import 'package:flutter/material.dart';
import 'package:note_app/views/widgets/auth/login_widgets/login_fields.dart';
import 'package:note_app/views/widgets/auth/login_widgets/login_header.dart';
import 'login_footer.dart';
class LoginBody extends StatelessWidget {
  const LoginBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LoginHeader(),
              const SizedBox(height: 32),
              LoginFields(),
              const SizedBox(height: 16),
              LoginFooter(),
            ],
          ),
        ),
      ),
    );
  }
}
