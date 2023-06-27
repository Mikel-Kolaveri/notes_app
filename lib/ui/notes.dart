// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
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

// final titleTextProvider = StateProvider<String>((ref) {
//   return '';
// });

// final contentTextProvider = StateProvider<String>((ref) {
//   return '';
// });

class _NotesWidgetState extends ConsumerState<NotesWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // ref.watch(titleTextProvider.notifier).state = widget.title;
        // ref.watch(contentTextProvider.notifier).state = widget.content;
        context.push('/open_note');
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        width: double.infinity,
        decoration: BoxDecoration(
          color: widget.color,
          borderRadius: const BorderRadius.all(Radius.circular(12)),
        ),
        child: Text(
          widget.title,
          style: GoogleFonts.nunito(color: Colors.black, fontSize: 25),
        ),
      ),
    );
  }
}
