import 'package:flutter/material.dart';
import 'package:note_app/views/widgets/auth/sign_up_widgets/sign_up_fields.dart';
import 'package:note_app/views/widgets/auth/sign_up_widgets/sign_up_footer.dart';
import 'package:note_app/views/widgets/auth/sign_up_widgets/sign_up_header.dart';
class SignUpBody extends StatelessWidget {
  const SignUpBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SignUpHeader(),
              const SizedBox(height: 32),
              SignUpFields(),
              const SizedBox(height: 16),
              SignUpFooter()
            ],
          ),
        ),
      ),
    );
  }
}
