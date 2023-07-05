// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notes_app/ui/notes/notes.dart';
import 'package:notes_app/ui/notes/src/notes_methods.dart';

import '../../../ui/custom_icon_button.dart';

final searchListProvider = StateProvider<List<NotesWidget>>((ref) {
  return ref.watch(noteslistProvider);
});

class Header extends ConsumerStatefulWidget {
  const Header({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HeaderState();
}

final showTextFieldProvider = StateProvider<bool>((ref) => true);

class _HeaderState extends ConsumerState<Header> {
  @override
  Widget build(BuildContext context) {
    bool textFieldshown = ref.watch(showTextFieldProvider);
    TextEditingController controller = TextEditingController();

    void showHideTextField() {
      ref.watch(showTextFieldProvider.notifier).state =
          !ref.watch(showTextFieldProvider.notifier).state;
    }

    var wigetOptions1 = Row(children: [
      Text(
        'Notes',
        style: GoogleFonts.nunito(
            color: Colors.white, fontWeight: FontWeight.w400, fontSize: 43),
      ),
      const Spacer(),
      CustomIconButton(icon: Icons.search, onPressed: showHideTextField),
      const SizedBox(
        width: 16,
      ),
      CustomIconButton(icon: Icons.info_outline, onPressed: () {})
    ]);

    return SizedBox(
      height: 56,
      child: textFieldshown
          ? wigetOptions1
          : Expanded(
              child: TextFormField(
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    suffixIcon: IconButton(
                      icon: const Icon(
                        Icons.clear,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        if (controller.text.isEmpty) {
                          showHideTextField();
                        }
                        controller.text = '';
                        ref.watch(searchListProvider.notifier).state =
                            ref.watch(noteslistProvider);
                      },
                    ),
                    filled: true,
                    fillColor: const Color(0xFF3B3B3B),
                    border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30)))),
                controller: controller,
                onChanged: (value) {
                  if (value.isEmpty) {
                    ref.watch(searchListProvider.notifier).state =
                        ref.watch(noteslistProvider);
                  }
                  ref.watch(searchListProvider.notifier).state = ref
                      .watch(noteslistProvider)
                      .where((note) => note.title.contains(value))
                      .toList();
                },
                onTapOutside: (_) {
                  if (controller.text.isEmpty) {
                    showHideTextField();
                  }
                },
              ),
            ),
    );
  }
}
