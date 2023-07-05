import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notes_app/pages/home_page/src/header.dart';
import 'package:notes_app/ui/gap.dart';

import '../new_note_page/new_note_page.dart';

final _notesEmptyWidget = [
  const Spacer(),
  Column(
    children: [
      Image.asset('assets/create_your_first_note.png'),
      Text(
        'Create your first note',
        style: GoogleFonts.nunito(
            color: Colors.white, fontSize: 20, fontWeight: FontWeight.w100),
      ),
    ],
  ),
  const Spacer()
];

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  void _editNewNote() {
    context.push('/new_note');
    ref.watch(noteTitleProvider.notifier).state = '';
    ref.watch(noteContentProvider.notifier).state = '';
    ref.watch(isNewNoteProvider.notifier).state = true;
    ref.watch(isReadOnlyProvider.notifier).state = false;
  }

  @override
  Widget build(BuildContext context) {
    // final notes = ref.watch(noteslistProvider);
    final notesList = ref.watch(searchListProvider);
    return Stack(
      children: [
        CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Column(
                children: [
                  const Header(),
                  const VGap(16),
                  if (notesList.isEmpty) ..._notesEmptyWidget else ...notesList,
                ],
              ),
            ),
          ],
        ),
        Positioned(
          bottom: 8,
          right: 8,
          child: FloatingActionButton(
            backgroundColor: const Color(0xFF252525),
            onPressed: _editNewNote,
            child: const Icon(
              Icons.add,
              size: 24,
            ),
          ),
        )
      ],
    );
  }
}
