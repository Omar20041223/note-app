import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/note_model.dart';

class FirestoreService {
  final CollectionReference notesCollection =
  FirebaseFirestore.instance.collection('notes');

  Future<void> addNote(NoteModel note) async {
    await notesCollection.add(note.toJson());
  }

  Stream<List<NoteModel>> getNotes() {
    return notesCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return NoteModel.fromJson(doc.data() as Map<String, dynamic>, doc.id,
            (doc['createdAt'] as Timestamp).toDate());
      }).toList();
    });
  }

  Future<void> deleteNote(String id) async {
    await notesCollection.doc(id).delete();
  }
  Future<void> updateNote(String id, Map<String, dynamic> data) async {
    await notesCollection.doc(id).update(data);
  }

}
