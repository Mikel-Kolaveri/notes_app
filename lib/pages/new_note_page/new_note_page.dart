import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:notes_app/pages/new_note_page/src/save_changes_dialog.dart';
import 'package:notes_app/pages/new_note_page/src/new_note_textfield.dart';
import 'package:notes_app/ui/notes/notes.dart';
import 'package:notes_app/ui/notes/src/notes_methods.dart';

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

final isNewNoteProvider = StateProvider<bool>((ref) {
  return false;
});

class NewNotePage extends ConsumerStatefulWidget {
  const NewNotePage(
      {super.key, this.title, this.content, this.isReadOnly = false});

  final String? title;
  final String? content;
  final bool isReadOnly;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _NewNotePageState();
}

class _NewNotePageState extends ConsumerState<NewNotePage> {
  @override
  Widget build(BuildContext context) {
    final notes = ref.watch(noteslistProvider);
    final notesMethods = ref.watch(noteslistProvider.notifier);

    final title = ref.watch(noteTitleProvider);
    final content = ref.watch(noteContentProvider);
    var isReadOnly = ref.watch(isReadOnlyProvider);

    final isNewNote = ref.watch(isNewNoteProvider);

    final TextEditingController titleController =
        TextEditingController(text: title);
    final TextEditingController contentController =
        TextEditingController(text: content);

    void onBackButtonTap() {
      if (widget.isReadOnly) {
        context.go('/'); // TODO: fix logic
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

    void readOnlySwitch() {
      ref.watch(noteTitleProvider.notifier).state = titleController.text;
      ref.watch(noteContentProvider.notifier).state = contentController.text;
      // Set the state of title and content if the user is editing a new note, so they don't reset on readOnlySwitch
      ref.watch(isReadOnlyProvider.notifier).state = !isReadOnly;
      isReadOnly = !isReadOnly;
    }

    void createNote() {
      if (contentController.text.isNotEmpty) {
        ref.watch(noteTitleProvider.notifier).state = titleController.text;
        ref.watch(noteContentProvider.notifier).state = contentController.text;
        notesMethods.addNote(NotesWidget(
          color: noteColors[notes.length % noteColors.length],
          content: ref.watch(noteContentProvider),
          title: ref.watch(noteTitleProvider),
          key: UniqueKey(),
        ));

        context.pop();
      }
    }

    void saveNote() {
      if (!isNewNote) {
        ref.watch(noteslistProvider.notifier).updateNote(
            ref.watch(noteIdProvider),
            titleController.text,
            contentController.text);
      } else {
        createNote();
      }
    }

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CustomIconButton(
                  iconPadding: const EdgeInsets.only(left: 6),
                  onPressed: onBackButtonTap,
                  icon: Icons.arrow_back_ios),
              const Spacer(),
              isReadOnly
                  ? CustomIconButton(
                      icon: Icons.edit, onPressed: readOnlySwitch)
                  : Row(
                      children: [
                        CustomIconButton(
                            icon: Icons.remove_red_eye_outlined,
                            onPressed: () {
                              readOnlySwitch();
                            }),
                        const HGap(16),
                        CustomIconButton(
                            icon: Icons.save_outlined, onPressed: saveNote),
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
      ),
    );
  }
}
