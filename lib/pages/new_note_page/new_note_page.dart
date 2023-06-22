import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:notes_app/pages/new_note_page/src/save_changes_dialog.dart';
import 'package:notes_app/pages/new_note_page/src/new_note_textfield.dart';

import '../../ui/custom_icon_button.dart';
import '../../ui/gap.dart';

class NewNotePage extends ConsumerStatefulWidget {
  const NewNotePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _NewNotePageState();
}

class _NewNotePageState extends ConsumerState<NewNotePage> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    void onBackButtonPress() {
      if (titleController.text.isEmpty && contentController.text.isEmpty) {
        context.pop();
      } else {
        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) => const SaveChangesDialog(),
        );
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            CustomIconButton(
                iconPadding: const EdgeInsets.only(left: 6),
                onPressed: onBackButtonPress,
                icon: Icons.arrow_back_ios),
            const Spacer(),
            CustomIconButton(
                icon: Icons.remove_red_eye_outlined, onPressed: () {}),
            const HGap(16),
            CustomIconButton(icon: Icons.save_outlined, onPressed: () {}),
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
