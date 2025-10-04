import 'package:go_router/go_router.dart';
import 'package:note_app/helpers/routes.dart';
import 'package:note_app/views/create_note_view.dart';
import 'package:note_app/views/login_view.dart';
import 'package:note_app/views/note_details_view.dart';
import 'package:note_app/views/note_list_view.dart';
import 'package:note_app/views/signup_view.dart';
import 'package:note_app/views/widgets/auth/auth_gate.dart';


abstract class AppRouter {
static final router =GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const AuthGate(),
    ),
    GoRoute(
      path: Routes.login,
      builder: (context, state) => const LoginView(),
    ),
    GoRoute(
      path: Routes.signUp,
      builder: (context, state) => const SignUpView(),
    ),
    GoRoute(
      path: Routes.createNote,
      builder: (context, state) => const CreateNoteView(),
    ),
    GoRoute(
      path: Routes.notesList,
      builder: (context, state) => const NoteListView(),
    ),
    GoRoute(
      path: Routes.noteDetails,
      builder: (context, state) {
        final data = state.extra as Map<String, dynamic>;
        final String noteId = data['noteId'] ?? '';
        return NoteDetailsView(noteId: noteId,);
      },
    ),
  ],
);
}