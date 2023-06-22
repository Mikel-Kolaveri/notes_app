// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class NotesWidget extends ConsumerStatefulWidget {
  const NotesWidget({
    super.key,
    this.title = 'Title',
    required this.color,
    this.content = '',
  });

  final String title;
  final Color color;
  final String content;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _NotesWidgetState();
}

class _NotesWidgetState extends ConsumerState<NotesWidget> {
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        padding: const EdgeInsets.all(16),
        width: double.infinity,
        decoration: BoxDecoration(
          color: widget.color,
          borderRadius: const BorderRadius.all(Radius.circular(12)),
        ),
        child: Text(
          '${widget.title} ',
          style: GoogleFonts.nunito(color: Colors.black, fontSize: 25),
        ),
      ),
    ]);
  }
}


// ignore: must_be_immutable
// class NoteWidget extends ConsumerWidget {
//   NoteWidget({
//     super.key,
//     this.title = '',
//     this.counter = 0,
//   }) {
//     counter++;
//   }

//   final String title;
//   static int _counter = 0;
//   int counter;

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return Container(
//       color: Colors.pink,
//       child: Text(
//         '$title counter is $counter',
//         style: GoogleFonts.nunito(color: Colors.black, fontSize: 25),
//       ),
//     );
//   }
// }