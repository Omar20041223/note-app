import 'package:flutter/material.dart';

import '../../../../helpers/app_styles.dart';
class SignUpHeader extends StatelessWidget {
  const SignUpHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Create Account', style: AppStyles.font22blackTextW700),
        const SizedBox(height: 8),
        Text('Sign up to get started', style: AppStyles.font16lightTextW400),
      ],
    );
  }
}
