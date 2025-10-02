import 'package:flutter/material.dart';
import 'package:note_app/views/widgets/create_note_widgets/create_note_body.dart';
import 'package:note_app/views/widgets/common_widgets/custom_app_bar.dart';
class CreateNoteView extends StatelessWidget {
  const CreateNoteView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(title: 'Create Note'),
      body: const CreateNoteBody(),
    );
  }
}
