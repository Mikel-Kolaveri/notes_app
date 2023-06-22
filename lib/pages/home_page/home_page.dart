import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notes_app/pages/home_page/src/header.dart';
import 'package:notes_app/ui/gap.dart';
import 'package:notes_app/ui/notes.dart';

final _colors = [
  Colors.yellow,
  Colors.green,
  Colors.pink,
  Colors.red,
  Colors.lightBlue
];

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

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<NotesWidget> notes = [];

  void _addNote() {
    setState(() {
      notes.add(NotesWidget(color: _colors[notes.length % _colors.length]));
    });
  }

  void _editNewNote() {
    context.push('/new_note');
    _addNote();
  }

  @override
  Widget build(BuildContext context) {
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
                  if (notes.isEmpty) ..._notesEmptyWidget else ...notes,
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
