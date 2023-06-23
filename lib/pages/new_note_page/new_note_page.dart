import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:notes_app/pages/home_page/home_page.dart';
import 'package:notes_app/pages/new_note_page/src/save_changes_dialog.dart';
import 'package:notes_app/pages/new_note_page/src/new_note_textfield.dart';
import 'package:notes_app/ui/notes.dart';

import '../../ui/custom_icon_button.dart';
import '../../ui/gap.dart';

final noteColors = [
  Colors.yellow,
  Colors.green,
  Colors.pink,
  Colors.red,
  Colors.lightBlue
];

final noteTitleProvider = StateProvider<String>((ref) {
  return '';
});

final noteContentProvider = StateProvider<String>((ref) {
  return '';
});

// final newNotePageStateProvider =
//     StateProvider<_NewNotePageState>((ref) => _NewNotePageState());

class NewNotePage extends ConsumerStatefulWidget {
  const NewNotePage({
    super.key,
    this.title = '',
    this.content = '',
  });

  final String title;
  final String content;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _NewNotePageState();
}

class _NewNotePageState extends ConsumerState<NewNotePage> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController titleController = TextEditingController(
        text: widget.title.isNotEmpty ? widget.title : '');
    final TextEditingController contentController = TextEditingController(
        text: widget.content.isNotEmpty ? widget.content : '');
    // ref.watch(noteContentProvider.notifier).state = titleController.text;
    // ref.watch(noteContentProvider.notifier).state = contentController.text;

    void onBackButtonTap() {
      if (contentController.text.isEmpty) {
        context.pop();
      } else {
        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) => const SaveChangesDialog(),
        );
      }
    }

    void addNote() {
      if (contentController.text.isNotEmpty) {
        setState(() {
          notes.add(NotesWidget(
            color: noteColors[notes.length % noteColors.length],
            content: contentController.text,
            title: titleController.text,
          ));
          context.pop();
        });
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            CustomIconButton(
                iconPadding: const EdgeInsets.only(left: 6),
                onPressed: onBackButtonTap,
                icon: Icons.arrow_back_ios),
            const Spacer(),
            CustomIconButton(
                icon: Icons.remove_red_eye_outlined,
                onPressed: () {
                  setState(() {});
                }),
            const HGap(16),
            CustomIconButton(icon: Icons.save_outlined, onPressed: addNote),
          ],
        ),
        const VGap(32),
        NewNoteTextField.title(
          controller: titleController,
        ),
        const VGap(16),
        NewNoteTextField.content(
          controller: contentController,
        ),
      ],
    );
  }
}
