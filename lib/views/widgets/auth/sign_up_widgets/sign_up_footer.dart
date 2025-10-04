import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../helpers/app_styles.dart';
import '../../../../helpers/routes.dart';
class SignUpFooter extends StatelessWidget {
  const SignUpFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Already have an account? ", style: AppStyles.font16blackTextW400),
            GestureDetector(
              onTap: () {
                GoRouter.of(context).push(Routes.login);
              },
              child: Text('Login', style: AppStyles.font16lightTextW400.copyWith(fontWeight: FontWeight.w700)),
            ),
          ],
        ),
      ],
    );
  }
}
