import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:notes_app/pages/home_page/home_page.dart';
import 'package:notes_app/pages/new_note_page/new_note_page.dart';

final router = GoRouter(routes: [
  ShellRoute(
      builder: (context, state, child) {
        return Scaffold(
          backgroundColor: const Color(0xFF252525),
          body: SafeArea(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
              child: child,
            ),
          ),
        );
      },
      routes: [
        GoRoute(
            path: '/',
            builder: (context, state) => const HomePage(),
            routes: [
              GoRoute(
                path: 'new_note',
                builder: (context, state) => const NewNotePage(),
              )
            ]),
      ])
]);
