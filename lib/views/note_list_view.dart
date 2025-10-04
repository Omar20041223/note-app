import 'package:flutter/material.dart';
import 'package:note_app/views/widgets/common_widgets/custom_app_bar.dart';
import 'package:note_app/views/widgets/note_list_widgets/note_list_body.dart';
class NoteListView extends StatelessWidget {
  const NoteListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(title: 'Notes List', context: context),
      body: NoteListBody(),
    );
  }
}
