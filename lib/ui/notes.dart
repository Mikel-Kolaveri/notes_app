// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notes_app/pages/home_page/home_page.dart';
import 'package:uuid/uuid.dart';
import '../pages/new_note_page/new_note_page.dart';

class NotesWidget extends ConsumerStatefulWidget {
  NotesWidget({
    super.key,
    this.title = 'Title',
    required this.color,
    this.content = '',
  }) : id = const Uuid().v4();

  final String title;
  final Color color;
  final String content;
  final String id;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _NotesWidgetState();
}

class _NotesWidgetState extends ConsumerState<NotesWidget> {
  void deleteNote() {
    setState(() {
      notes.removeWhere((note) => note.id == widget.id);
    });
  }

  void updateNote() {
    final note = notes.firstWhere((note) => note.id == widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
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
                  deleteNote();
                },
                icon: const Icon(Icons.delete))
          ],
        ),
      ),
    );
  }
}
