import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:note_app/helpers/extensions.dart';
import 'package:note_app/views/widgets/common_widgets/custom_app_bar.dart';
import 'package:note_app/views/widgets/note_details_widgets/note_details_body.dart';
import '../services/firestore_service.dart';
class NoteDetailsView extends StatelessWidget {
  final String noteId;

  const NoteDetailsView({super.key, required this.noteId});

  @override
  Widget build(BuildContext context) {
    final firestoreService = FirestoreService();

    return Scaffold(
      appBar: customAppBar(
        title: 'Note Details',
        onEdit: () {
          _showEditDialog(context, firestoreService);
        },
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: firestoreService.notesCollection.doc(noteId).snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());

          final data = snapshot.data!.data() as Map<String, dynamic>;
          final noteTitle = data['title'] ?? '';
          final noteContent = data['content'] ?? '';
          final noteDate = (data['createdAt'] as Timestamp).toDate();

          return NoteDetailsBody(
            noteTitle: noteTitle,
            noteContent: noteContent,
            noteDate: noteDate,
          );
        },
      ),
    );
  }

  void _showEditDialog(BuildContext context, FirestoreService firestoreService) {
    showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: const Text("What do you want to edit?"),
          children: [
            SimpleDialogOption(
              child: const Text("Edit Title"),
              onPressed: () {
                Navigator.pop(context);
                _editField(context, "title", firestoreService);
              },
            ),
            SimpleDialogOption(
              child: const Text("Edit Content"),
              onPressed: () {
                Navigator.pop(context);
                _editField(context, "content", firestoreService);
              },
            ),
          ],
        );
      },
    );
  }

  void _editField(BuildContext context, String field, FirestoreService firestoreService) {
    final controller = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Edit ${field == 'title' ? 'Title' : 'Content'}"),
          content: TextField(
            controller: controller,
            maxLines: field == "content" ? 5 : 1,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: "Enter new ${field == 'title' ? 'title' : 'content'}",
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () async {
                if (controller.text.trim().isNotEmpty) {
                  await firestoreService.updateNote(noteId, {
                    field: controller.text.trim(),
                  });
                  Navigator.pop(context);
                  context.showSnackBar(text: "Note updated successfully ✅");
                }
              },
              child: const Text("Save"),
            ),
          ],
        );
      },
    );
  }
}