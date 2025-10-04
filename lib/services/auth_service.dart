import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:note_app/models/auth/sign_up_request.dart';

import '../models/auth/login_request.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn(); // ✅ FIXED HERE

  /// 🔹 Sign up with Email & Password
  Future<User?> signUpWithEmail({
    required SignUpRequest signUpRequest,
  }) async {
    final result = await _auth.createUserWithEmailAndPassword(
      email: signUpRequest.email,
      password: signUpRequest.password,
    );

    final user = result.user;
    await user?.updateDisplayName(signUpRequest.fullName);

    await _firestore.collection('users').doc(user!.uid).set({
      'uid': user.uid,
      'fullName': signUpRequest.fullName,
      'email': signUpRequest.email,
      'createdAt': FieldValue.serverTimestamp(),
    });

    return user;
  }

  /// 🔹 Login with Email & Password
  Future<User?> loginWithEmail({
    required LoginRequest loginRequest,
  }) async {
    final result = await _auth.signInWithEmailAndPassword(
      email: loginRequest.email,
      password: loginRequest.password,
    );
    return result.user;
  }

  /// 🔹 Google Sign-In
  Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn(); // ✅ FIXED
      if (googleUser == null) return null;

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken, // ✅ FIXED
        idToken: googleAuth.idToken,
      );

      final userCredential = await _auth.signInWithCredential(credential);
      final user = userCredential.user;

      if (user != null) {
        final userDoc = _firestore.collection('users').doc(user.uid);
        if (!(await userDoc.get()).exists) {
          await userDoc.set({
            'uid': user.uid,
            'email': user.email,
            'fullName': user.displayName ?? '',
            'photoURL': user.photoURL,
            'createdAt': FieldValue.serverTimestamp(),
          });
        }
      }

      return user;
    } catch (e) {
      print('Google Sign-In Error: $e');
      rethrow;
    }
  }

  /// 🔹 Logout
  Future<void> logout() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
  }

  User? get currentUser => _auth.currentUser;
  Stream<User?> get authStateChanges => _auth.authStateChanges();
}
