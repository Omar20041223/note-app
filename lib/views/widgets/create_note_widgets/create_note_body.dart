import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:note_app/helpers/extensions.dart';
import 'package:note_app/helpers/routes.dart';
import 'package:note_app/models/note_model.dart';
import 'package:note_app/views/widgets/common_widgets/custom_button.dart';
import 'package:note_app/views/widgets/create_note_widgets/create_note_text_field.dart';

import '../../../helpers/app_colors.dart';
import '../../../services/firestore_service.dart';

class CreateNoteBody extends StatefulWidget {
  const CreateNoteBody({super.key});

  @override
  State<CreateNoteBody> createState() => _CreateNoteBodyState();
}

class _CreateNoteBodyState extends State<CreateNoteBody> {
  late TextEditingController noteTitleController;
  late TextEditingController noteContentController;
  final firestoreService = FirestoreService();

  @override
  void initState() {
    noteTitleController = TextEditingController();
    noteContentController = TextEditingController();
    super.initState();
  }

  Future<void> addNote() async {
    // Add note to database
    final note = NoteModel(
      id: '',
      title: noteTitleController.text.trim(),
      content: noteContentController.text.trim(),
      createdAt: DateTime.now(),
    );
    await firestoreService.addNote(note);
  }

  @override
  void dispose() {
    noteTitleController.dispose();
    noteContentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          CreateNoteTextField(
            title: 'Note Title',
            hintText: 'Enter Note Title',
            controller: noteTitleController,
          ),
          SizedBox(height: 12),
          CreateNoteTextField(
            title: 'Note Content',
            hintText: 'Enter Note Content',
            height: 176,
            controller: noteContentController,
          ),
          Spacer(),
          CustomButton(
            text: 'Save Note',
            buttonColor: AppColors.lightText,
            onTap: () async {
              if (noteTitleController.text.isEmpty ||
                  noteContentController.text.isEmpty) {
                context.showSnackBar(text: 'Please fill all fields');
                return;
              }
              await addNote();
              context.showSnackBar(text: 'Note saved successfully ✅');
              noteTitleController.clear();
              noteContentController.clear();
            },
          ),
          SizedBox(height: 12),
          CustomButton(
            text: 'View Note',
            buttonColor: Colors.white,
            onTap: () {
              GoRouter.of(context).push(Routes.notesList);
            },
          ),
        ],
      ),
    );
  }
}
