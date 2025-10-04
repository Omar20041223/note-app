import 'package:flutter/material.dart';

import '../../../helpers/app_colors.dart';
import '../../../helpers/app_styles.dart';
class AuthField extends StatefulWidget {
  const AuthField({super.key, required this.title, required this.controller, required this.validator, this.isPasswordField = false,});
  final String title;
  final TextEditingController controller;
  final String? Function(String?) validator;
  final bool isPasswordField;

  @override
  State<AuthField> createState() => _AuthFieldState();
}

class _AuthFieldState extends State<AuthField> {
  bool obscureText = true;
  @override
  Widget build(BuildContext context) {
    Widget? isPassword(){
      if(widget.isPasswordField){
        return obscureText ? IconButton(icon: const Icon(Icons.visibility_off),onPressed: (){
          obscureText = !obscureText;
          setState(() {});
        },) : IconButton(icon: const Icon(Icons.visibility),onPressed: (){
          obscureText = !obscureText;
          setState(() {});
        },);
      }
      return null;
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.title, style: AppStyles.font16blackTextW500),
        const SizedBox(height: 8),
        TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          controller: widget.controller,
          validator: widget.validator,
          obscureText: widget.isPasswordField ? obscureText : false,
          decoration: InputDecoration(
            suffixIcon: isPassword(),
            filled: true,
            fillColor: AppColors.textFieldFill,
            border: OutlineInputBorder(
              borderSide: const BorderSide(color: AppColors.textFieldBorder),
              borderRadius: BorderRadius.circular(8),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: AppColors.textFieldBorder),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ],
    );
  }
}
