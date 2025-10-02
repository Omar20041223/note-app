import 'package:flutter/material.dart';
import 'package:note_app/helpers/app_styles.dart';

class NoteDetailsBody extends StatelessWidget {
  const NoteDetailsBody({
    super.key,
    required this.noteTitle,
    required this.noteContent,
    required this.noteDate,
  });

  final String noteTitle;
  final String noteContent;
  final DateTime noteDate;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(noteTitle, style: AppStyles.font22blackTextW700),
          SizedBox(height: 16),
          Text(noteContent, style: AppStyles.font16blackTextW400),
          SizedBox(height: 8),
          Text(
            'Created At: ${noteDate.month}/${noteDate.day}/${noteDate.year} ${noteDate.hour}:${noteDate.minute}',
            style: AppStyles.font14lightTextW400,
          ),
        ],
      ),
    );
  }
}
