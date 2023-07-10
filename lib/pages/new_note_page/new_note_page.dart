import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:notes_app/pages/new_note_page/src/save_changes_dialog.dart';
import 'package:notes_app/pages/new_note_page/src/new_note_textfield.dart';
import 'package:notes_app/ui/notes/note_widget.dart';
import 'package:notes_app/ui/notes/src/note.dart';
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

final colorListIndexProvider = StateProvider<int>((ref) => 0);

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
  final FocusNode titleFocusNode = FocusNode();
  final FocusNode contentFocusNode = FocusNode();
  @override
  void dispose() {
    titleFocusNode.dispose();
    contentFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final notesMethods = ref.watch(noteslistProvider.notifier);

    final title = ref.watch(noteTitleProvider);
    final content = ref.watch(noteContentProvider);
    var isReadOnly = ref.watch(isReadOnlyProvider);

    final isNewNote = ref.watch(isNewNoteProvider);

    final TextEditingController titleController = TextEditingController(
      text: title,
    );
    final TextEditingController contentController = TextEditingController(
      text: content,
    );
    // TODO: make changes to be able to call dispose method on controllers

    int index = ref.watch(colorListIndexProvider);

    void createNote() {
      if (contentController.text.isNotEmpty ||
          titleController.text.isNotEmpty) {
        ref.watch(noteTitleProvider.notifier).state = titleController.text;
        ref.watch(noteContentProvider.notifier).state = contentController.text;

        notesMethods.addNote(
          Note(
            content: ref.watch(noteContentProvider),
            title: ref.watch(noteTitleProvider),
            color: noteColors[index % noteColors.length],
          ),
        );

        ref.watch(colorListIndexProvider.notifier).state++;

        if (index == noteColors.length - 1) {
          ref.watch(colorListIndexProvider.notifier).state = 0;
        }

        ref.watch(isNewNoteProvider.notifier).state = false;
        ref.watch(noteIdProvider.notifier).state =
            ref.watch(noteslistProvider).last.id;
        // if it's a just created note, refer to the id of that note
        // by referring to the last item of the notes list
        titleFocusNode.unfocus();
        contentFocusNode.unfocus();
      }
    }

    void saveNote() {
      if (!isNewNote) {
        ref.watch(noteslistProvider.notifier).updateNote(
            ref.watch(noteIdProvider),
            titleController.text,
            contentController.text);
        ref.watch(noteTitleProvider.notifier).state = titleController.text;
        ref.watch(noteContentProvider.notifier).state = contentController.text;
        titleFocusNode.unfocus();
        contentFocusNode.unfocus();
      } else {
        createNote();
      }
    }

    void onBackButtonTap() {
      if (isNewNote) {
        if (titleController.text.isEmpty && contentController.text.isEmpty) {
          context.pop();
        } else {
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) => SaveChangesDialog(onSaveButtonTap: () {
              saveNote();
              context.pop();
              context.pop();
            }),
          );
        }
      } else {
        if (titleController.text == title &&
            contentController.text == content) {
          context.pop();
        } else {
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) => SaveChangesDialog(
              onSaveButtonTap: () {
                saveNote();
                context.pop();
                context.pop();
              },
            ),
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
            focusNode: titleFocusNode,
          ),
          const VGap(16),
          NewNoteTextField.content(
            controller: contentController,
            enabled: isReadOnly ? false : true,
            focusNode: contentFocusNode,
          ),
        ],
      ),
    );
  }
}
