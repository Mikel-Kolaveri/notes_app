// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notes_app/ui/notes/src/notes_methods.dart';

import '../../../ui/custom_icon_button.dart';
import '../../../ui/notes/src/note.dart';

final searchListProvider = StateProvider<List<Note>>((ref) {
  return ref.watch(noteslistProvider);
});

final isUserSearchingProvider = StateProvider<bool>((ref) {
  return false;
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
    final isUserSearchingNotifier = ref.watch(isUserSearchingProvider.notifier);
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
          : Row(children: [
              Expanded(
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
                          isUserSearchingNotifier.state = false;
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

                      isUserSearchingNotifier.state = false;
                    } else {
                      isUserSearchingNotifier.state = true;
                    }

                    ref.watch(searchListProvider.notifier).state = ref
                        .watch(noteslistProvider)
                        .where((note) => note.title.contains(value))
                        .toList();
                  },
                  onTapOutside: (_) {
                    if (controller.text.isEmpty) {
                      showHideTextField();
                      isUserSearchingNotifier.state = false;
                    }
                  },
                ),
              ),
            ]),
    );
  }
}
