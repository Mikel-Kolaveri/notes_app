import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notes_app/pages/home_page/src/header.dart';
import 'package:notes_app/ui/gap.dart';
import 'package:notes_app/ui/notes/note_widget.dart';
import 'package:notes_app/ui/notes/src/note.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../ui/notes/src/notes_methods.dart';
import '../new_note_page/new_note_page.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

final homePageStateProvider = Provider<_HomePageState>((ref) {
  return _HomePageState();
});

class _HomePageState extends ConsumerState<HomePage> {
  List<Note> notes = [];
  // int colorIndex = 0;

  @override
  void initState() {
    super.initState();
    loadLocalData();
  }

  //Loading counter value on start
  Future<void> loadLocalData() async {
    final prefs = await SharedPreferences.getInstance();

    ref.watch(titlesProvider.notifier).state =
        prefs.getStringList('titlesList') ?? [];

    ref.watch(contentsProvider.notifier).state =
        prefs.getStringList('contentsList') ?? [];

    // colorIndex= ref.watch(colorListIndexProvider.notifier).state = prefs.getInt('colorString') ?? 0;

    notes = ref.watch(notesToDisplayProvider.notifier).state = List.generate(
        ref.watch(titlesProvider).length,
        (index) => Note(
            content: ref.watch(contentsProvider)[index],
            title: ref.watch(titlesProvider)[index],
            color: noteColors[index % noteColors.length]));
    //TODO: Make colors be the same when you relaunch the app

    ref.watch(noteslistProvider.notifier).state = notes;
  }

  //Incrementing counter after click

  void _editNewNote() {
    context.push('/new_note');
    ref.watch(noteTitleProvider.notifier).state = '';
    ref.watch(noteContentProvider.notifier).state = '';
    ref.watch(isNewNoteProvider.notifier).state = true;
    ref.watch(isReadOnlyProvider.notifier).state = false;
  }

  @override
  Widget build(BuildContext context) {
    final notesList = ref.watch(searchListProvider);

    final notesToDisplay = ref.watch(notesToDisplayProvider);

    final isUserSearching = ref.watch(isUserSearchingProvider);
    final notesWidgetList = List.generate(
      notesList.length,
      (index) => NotesWidget(note: notesList[index]),
    );

    final notesEmptyWidget = [
      const Spacer(),
      Column(
        children: [
          Image.asset(isUserSearching
              ? 'assets/search_no_file_found.png'
              : 'assets/create_your_first_note.png'),
          Text(
            isUserSearching
                ? 'File not found. Try searching again.'
                : 'Create your first note',
            style: GoogleFonts.nunito(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.w100),
          ),
        ],
      ),
      const Spacer()
    ];

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
                  if (notesWidgetList.isEmpty)
                    ...notesEmptyWidget
                  else
                    ...notesWidgetList
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
