import 'package:flutter/material.dart';
import '../../../helpers/app_colors.dart';
import '../../../helpers/app_styles.dart';
class CustomButton extends StatelessWidget {
  const CustomButton({super.key, required this.text, this.onTap, required this.buttonColor});
  final String text;
  final void Function()? onTap;
  final Color buttonColor;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 48,
        width: double.infinity,
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(child: Text(text, style: AppStyles.font16blackTextW700,)),
      ),
    );
  }
}
