import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/note_model.dart';

class FirestoreService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Reference to the current user's notes collection
  CollectionReference<Map<String, dynamic>> get _userNotesCollection {
    final user = _auth.currentUser;
    if (user == null) {
      throw Exception('No user logged in');
    }
    return _firestore.collection('users').doc(user.uid).collection('notes');
  }

  /// Add a note for the current user
  Future<void> addNote(NoteModel note) async {
    await _userNotesCollection.add(note.toJson());
  }

  /// Stream all notes for the current user
  Stream<List<NoteModel>> getNotes() {
    return _userNotesCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return NoteModel.fromJson(
          doc.data(),
          doc.id,
          (doc['createdAt'] as Timestamp).toDate(),
        );
      }).toList();
    });
  }
  Stream<DocumentSnapshot> getNoteById(String id) {
    return _userNotesCollection.doc(id).snapshots();
  }

  /// Delete a note by ID
  Future<void> deleteNote(String id) async {
    await _userNotesCollection.doc(id).delete();
  }

  /// Update a note
  Future<void> updateNote(String id, Map<String, dynamic> data) async {
    await _userNotesCollection.doc(id).update(data);
  }
}
