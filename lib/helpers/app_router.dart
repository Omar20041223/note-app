import 'package:go_router/go_router.dart';
import 'package:note_app/helpers/routes.dart';
import 'package:note_app/views/create_note_view.dart';
import 'package:note_app/views/note_details_view.dart';
import 'package:note_app/views/note_list_view.dart';


abstract class AppRouter {
static final router =GoRouter(
  routes: [
    GoRoute(
      path: '/',
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