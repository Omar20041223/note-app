import 'package:flutter/material.dart';

import '../../../../helpers/app_styles.dart';
class LoginHeader extends StatelessWidget {
  const LoginHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Welcome Back', style: AppStyles.font22blackTextW700),
        const SizedBox(height: 8),
        Text('Login to your account', style: AppStyles.font16lightTextW400),
      ],
    );
  }
}
