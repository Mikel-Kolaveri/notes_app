// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notes_app/ui/notes/src/notes_methods.dart';
import 'package:uuid/uuid.dart';
import '../../pages/new_note_page/new_note_page.dart';

final noteIdProvider = StateProvider<String>((ref) {
  return '';
});

// ignore: must_be_immutable
class NotesWidget extends ConsumerStatefulWidget {
  //TODO: create a class to store the objects instead of changing the widget from within
  NotesWidget({
    super.key,
    this.title = 'Title',
    required this.color,
    this.content = '',
  }) : id = const Uuid().v4();

  String title;
  final Color color;
  String content;
  final String id;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _NotesWidgetState();
}

class _NotesWidgetState extends ConsumerState<NotesWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        ref.watch(isNewNoteProvider.notifier).state = false;
        ref.watch(noteIdProvider.notifier).state = widget.id;
        context.push('/open_note');
        ref.watch(noteTitleProvider.notifier).state = widget.title;
        ref.watch(noteContentProvider.notifier).state = widget.content;
        ref.watch(isReadOnlyProvider.notifier).state = false;
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        width: double.infinity,
        decoration: BoxDecoration(
          color: widget.color,
          borderRadius: const BorderRadius.all(Radius.circular(12)),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                widget.title,
                style: GoogleFonts.nunito(color: Colors.black, fontSize: 25),
              ),
            ),
            IconButton(
                onPressed: () {
                  ref.watch(noteslistProvider.notifier).deleteNote(widget.id);
                },
                icon: const Icon(Icons.delete))
          ],
        ),
      ),
    );
  }
}
