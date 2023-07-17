import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notes_app/pages/home_page/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'note.dart';

class NotesMethods extends Notifier<List<Note>> {
  @override
  List<Note> build() {
    return [];
  }

  List<String> titles = [];
  List<String> contents = [];

  void addNote(Note note) {
    state = [...state, note];
    _updateState();
  }

  void deleteNote(String id) {
    state.removeWhere((note) => note.id == id);
    state = [...state];
    _updateState();
  }

  void updateNote(String id, String title, String content) {
    final noteToedit = state.firstWhere((note) => note.id == id);
    noteToedit.title = title;
    noteToedit.content = content;
    _updateState();
  }

  void _updateState() {
    ref.watch(notesToDisplayProvider.notifier).state = state;
    titles = ref.watch(titlesProvider.notifier).state =
        state.map((e) => e.title).toList();
    contents = ref.watch(contentsProvider.notifier).state =
        state.map((e) => e.content).toList();
    // titles = ref.watch(titlesProvider);
    // contents = ref.watch(contentsProvider);
    // print(ref.watch(titlesProvider));
    // print(ref.watch(contentsProvider));
    saveLocalData();
  }

  Future<void> saveLocalData() async {
    final prefs = await SharedPreferences.getInstance();

    prefs.setStringList('titlesList', titles);

    prefs.setStringList('contentsList', contents);

    print(titles);
  }
}

final noteslistProvider =
    NotifierProvider<NotesMethods, List<Note>>(NotesMethods.new);

final titlesProvider = StateProvider<List<String>>((ref) {
  return [];
});

final contentsProvider = StateProvider<List<String>>((ref) {
  return [];
});

final notesToDisplayProvider = StateProvider<List<Note>>((ref) {
  return [];
});
