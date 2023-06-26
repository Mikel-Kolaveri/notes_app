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

final isReadOnlyProvider = StateProvider<bool>((ref) {
  return false;
});

// final newNotePageStateProvider =
//     StateProvider<_NewNotePageState>((ref) => _NewNotePageState());

class NewNotePage extends ConsumerStatefulWidget {
  const NewNotePage(
      {super.key, this.title = '', this.content = '', this.isReadOnly = false});

  final String title;
  final String content;
  final bool isReadOnly;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _NewNotePageState();
}

class _NewNotePageState extends ConsumerState<NewNotePage> {
  @override
  Widget build(BuildContext context) {
    // ref.watch(isReadOnlyProvider.notifier).state = widget.isReadOnly;
    final TextEditingController titleController = TextEditingController(
        text: widget.title.isNotEmpty ? widget.title : null);
    final TextEditingController contentController = TextEditingController(
        text: widget.content.isNotEmpty ? widget.content : null);

    var isReadOnly = ref.watch(isReadOnlyProvider);

    void onBackButtonTap() {
      if (widget.isReadOnly) {
        context.go('/');
      } else {
        if (titleController.text.isEmpty) {
          context.pop();
        } else {
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) => const SaveChangesDialog(),
          );
        }
      }
    }

    void readOnlSwitch() {
      // TODO: Fix title clearing when switching
      ref.watch(isReadOnlyProvider.notifier).state = !isReadOnly;

      isReadOnly = !isReadOnly;
    }

    // void onReadOnlyButtonTap() {
    //   if (ref.watch(titleTextProvider).isEmpty) {
    //     ref.watch(isReadOnlyProvider.notifier).state = !isReadOnly;
    //     isReadOnly = ref.watch(isReadOnlyProvider);
    //   }
    //   context.go('/open_note');
    // }

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
            widget.isReadOnly
                ? CustomIconButton(
                    icon: Icons.edit,
                    onPressed: () {
                      // TODO
                    })
                : Row(
                    children: [
                      CustomIconButton(
                          icon: Icons.remove_red_eye_outlined,
                          onPressed: () {
                            readOnlSwitch();
                          }),
                      const HGap(16),
                      CustomIconButton(
                          icon: Icons.save_outlined, onPressed: addNote),
                    ],
                  )
          ],
        ),
        const VGap(32),
        NewNoteTextField.title(
          controller: titleController,
          enabled: isReadOnly ? false : true,
        ),
        const VGap(16),
        NewNoteTextField.content(
          controller: contentController,
          enabled: isReadOnly ? false : true,
        ),
      ],
    );
  }
}
