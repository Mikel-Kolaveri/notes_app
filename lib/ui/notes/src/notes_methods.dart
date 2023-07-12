import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'note.dart';

// class TitleMethods extends Notifier<List<String>> {
//   @override
//   List<String> build() => [];

//   List<String> addTitle(String title) {
//   return  state = [...state, title];
//   }

//   void deleteTitle(String id) {
//       state.removeWhere((element) => false);
//   }
// // }
// class TitleMethods extends Notifier<List<String>> {
//   @override
//   List<String> build() => [];

//   void addTitle(String title) {
//     state = [...state, title];
//   }

//   void deleteTitle(String id) {
//     state.removeWhere((element) => false);
//   }
// }

// final titleListProvider =
//     NotifierProvider<TitleMethods, List<String>>(TitleMethods.new);

class NotesMethods extends Notifier<List<Note>> {
  @override
  List<Note> build() {
    return [];
  }

  void addNote(Note note) {
    state = [...state, note];
    ref.watch(titlesProvider.notifier).state =
        state.map((e) => e.title).toList();
    ref.watch(contentsProvider.notifier).state =
        state.map((e) => e.content).toList();
  }

  void deleteNote(String id) {
    state.removeWhere((note) => note.id == id);
    state = [...state];
    ref.watch(titlesProvider.notifier).state =
        state.map((e) => e.title).toList();
    ref.watch(contentsProvider.notifier).state =
        state.map((e) => e.content).toList();
  }

  void updateNote(String id, String title, String content) {
    final noteToedit = state.firstWhere((note) => note.id == id);
    noteToedit.title = title;
    noteToedit.content = content;
    ref.watch(titlesProvider.notifier).state =
        state.map((e) => e.title).toList();
    ref.watch(contentsProvider.notifier).state =
        state.map((e) => e.content).toList();
  }

  // void clearList() {
  //   state = [];
  // }
}

final noteslistProvider =
    NotifierProvider<NotesMethods, List<Note>>(NotesMethods.new);

final titlesProvider = StateProvider<List<String>>((ref) {
  return [];
});

final contentsProvider = StateProvider<List<String>>((ref) {
  return [];
});

final localListProvider = StateProvider<List<Note>>(
  (ref) => List.generate(
    ref.watch(noteslistProvider).length,
    (index) => Note(
        content: (ref.watch(contentsProvider))[index],
        title: (ref.watch(titlesProvider))[index],
        color: Colors.white),
  ),
);
