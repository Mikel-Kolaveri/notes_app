import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'note.dart';

class NotesMethods extends Notifier<List<Note>> {
  @override
  List<Note> build() {
    return [];
  }

  void addNote(Note note) {
    state = [...state, note];
  }

  void deleteNote(String id) {
    state.removeWhere((note) => note.id == id);
    state = [...state];
  }

  void updateNote(String id, String title, String content) {
    final noteToedit = state.firstWhere((note) => note.id == id);
    noteToedit.title = title;
    noteToedit.content = content;
  }

  // void clearList() {
  //   state = [];
  // }
}

var noteslistProvider =
    NotifierProvider<NotesMethods, List<Note>>(NotesMethods.new);
