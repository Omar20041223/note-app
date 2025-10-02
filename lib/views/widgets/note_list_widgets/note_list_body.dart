import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:note_app/helpers/extensions.dart';
import 'package:note_app/models/note_model.dart';
import 'package:note_app/services/firestore_service.dart';
import 'package:note_app/views/widgets/note_list_widgets/note_list_list_tile.dart';

import '../../../helpers/routes.dart';

class NoteListBody extends StatelessWidget {
  const NoteListBody({super.key});

  @override
  Widget build(BuildContext context) {
    final firestoreService = FirestoreService();

    return StreamBuilder<List<NoteModel>>(
      stream: firestoreService.getNotes(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return const Center(child: Text('Something went wrong ❌'));
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No notes found 📝'));
        }

        final notes = snapshot.data!;

        return ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: notes.length,
          itemBuilder: (context, index) {
            final note = notes[index];
            return NoteListListTile(
              title: note.title,
              subtitle: note.content,
              onTap: () {
                GoRouter.of(context).push(
                  Routes.noteDetails,
                  extra: {
                    'noteId': note.id,
                  },
                );
              },
              onDelete: () async {
                await firestoreService.deleteNote(note.id);
                context.showSnackBar(text: "Note deleted ✅");
              },
            );
          },
        );
      },
    );
  }
}
