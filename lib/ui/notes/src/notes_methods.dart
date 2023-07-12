import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'note.dart';

class NotesMethods extends Notifier<List<Note>> {
  @override
  List<Note> build() {
    return [];
  }

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
    ref.watch(titlesProvider.notifier).state =
        state.map((e) => e.title).toList();
    ref.watch(contentsProvider.notifier).state =
        state.map((e) => e.content).toList();
    ref.watch(notesToDisplayProvider.notifier).state = state;
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
