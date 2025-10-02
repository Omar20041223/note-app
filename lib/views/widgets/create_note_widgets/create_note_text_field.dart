import 'package:flutter/material.dart';
import 'package:note_app/helpers/app_styles.dart';
import '../../../helpers/app_colors.dart';

class CreateNoteTextField extends StatelessWidget {
  const CreateNoteTextField({
    super.key,
    this.height,
    required this.title,
    required this.hintText, required this.controller,
  });

  final double? height;
  final String title;
  final String hintText;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: AppStyles.font16blackTextW500),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          textAlignVertical: TextAlignVertical.top,
          maxLines: height == null ? 1 : null, // if height passed → allow expansion
          minLines: height == null ? 1 : null,
          expands: height != null, // make it fill the given SizedBox
          decoration: InputDecoration(
            filled: true,
            fillColor: AppColors.textFieldFill,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: AppColors.textFieldBorder, width: 1),
            ),
            alignLabelWithHint: true, // keeps label at the top for multiline
            labelText: hintText,      // use label instead of hint
            labelStyle: AppStyles.font16lightTextW400,
          ),
        ).buildWithHeight(height), // 👈 extension for conditional height
      ],
    );
  }
}

extension on Widget {
  Widget buildWithHeight(double? height) {
    if (height == null) return this;
    return SizedBox(height: height, child: this);
  }
}
