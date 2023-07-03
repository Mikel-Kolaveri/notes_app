import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notes_app/ui/notes/notes.dart';

class StringGenerator extends Notifier<List<NotesWidget>> {
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
    NotifierProvider<StringGenerator, List<NotesWidget>>(StringGenerator.new);
