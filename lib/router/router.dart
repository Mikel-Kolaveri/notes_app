import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:notes_app/pages/home_page/home_page.dart';
import 'package:notes_app/pages/new_note_page/new_note_page.dart';
import 'package:notes_app/ui/notes.dart';

final router = GoRouter(routes: [
  ShellRoute(
      builder: (context, state, child) {
        return GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Scaffold(
            backgroundColor: const Color(0xFF252525),
            body: SafeArea(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
                child: child,
              ),
            ),
          ),
        );
      },
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const HomePage(),
        ),
        GoRoute(
            path: '/open_note',
            builder: (context, state) => const ReadOnlyNote())
      ]),
  GoRoute(
    path: '/new_note',
    builder: (context, state) {
      return GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: const Scaffold(
          backgroundColor: Color(0xFF252525),
          body: SafeArea(
            child: NewNotePage(),
          ),
        ),
      );
    },
  ),
]);

class ReadOnlyNote extends ConsumerWidget {
  const ReadOnlyNote({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return NewNotePage(
      title: ref.watch(titleTextProvider),
      content: ref.watch(contentTextProvider),
      isReadOnly: true,
    );
  }
}
