import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notes_app/ui/notes/notes.dart';

class NotesMethods extends Notifier<List<NotesWidget>> {
  @override
  List<NotesWidget> build() {
    return []; //throw UnimplementedError();
  }

  void addNote(NotesWidget note) {
    state = [...state, note];
  }

  void deleteNote(String id) {
    state.removeWhere((note) => note.id == id);
    state = [...state];
  }

  //TODO: fix bug where if you try to save a just saved note you get an error, steps:
  // Create new note, save with save button, change title or content, press save again
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
    NotifierProvider<NotesMethods, List<NotesWidget>>(NotesMethods.new);
