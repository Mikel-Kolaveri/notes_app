// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notes_app/ui/notes/src/note.dart';
import 'package:notes_app/ui/notes/src/notes_methods.dart';
import '../../pages/new_note_page/new_note_page.dart';

final noteIdProvider = StateProvider<String>((ref) {
  return '';
});

class NotesWidget extends ConsumerStatefulWidget {
  const NotesWidget({
    super.key,
    required this.note,
  });

  final Note note;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _NotesWidgetState();
}

class _NotesWidgetState extends ConsumerState<NotesWidget> {
  @override
  Widget build(BuildContext context) {
    final note = widget.note;
    String title = note.title;

    return GestureDetector(
      onTap: () {
        ref.watch(isNewNoteProvider.notifier).state = false;
        ref.watch(noteIdProvider.notifier).state = note.id;
        context.push('/open_note');
        ref.watch(noteTitleProvider.notifier).state = note.title;
        ref.watch(noteContentProvider.notifier).state = note.content;
        ref.watch(isReadOnlyProvider.notifier).state = false;
        print(note.id);
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        width: double.infinity,
        decoration: BoxDecoration(
          color: note.color,
          borderRadius: const BorderRadius.all(Radius.circular(12)),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: GoogleFonts.nunito(color: Colors.black, fontSize: 25),
              ),
            ),
            IconButton(
                onPressed: () {
                  ref.watch(noteslistProvider.notifier).deleteNote(note.id);
                },
                icon: const Icon(Icons.delete))
          ],
        ),
      ),
    );
  }
}
