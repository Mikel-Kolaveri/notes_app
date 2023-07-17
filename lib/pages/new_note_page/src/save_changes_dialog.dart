// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:notes_app/pages/new_note_page/src/dialog_button.dart';
import 'package:notes_app/ui/gap.dart';

class SaveChangesDialog extends ConsumerWidget {
  const SaveChangesDialog({
    super.key,
    required this.onSaveButtonTap,
  });

  final VoidCallback onSaveButtonTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Dialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
      backgroundColor: const Color(0xFF252525),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 32),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          const Icon(
            Icons.info,
            color: Colors.grey,
          ),
          const VGap(16),
          const Text(
            'Save changes ?',
            style: TextStyle(
              fontSize: 18,
              color: Color(0xFFCFCFCF),
            ),
          ),
          const VGap(32),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                  flex: 10,
                  child: DialogButton(
                    text: 'Discard',
                    color: const Color(0xFFFF0000),
                    onPressed: () {
                      context.pop();
                      context.pop();
                    },
                  )),
              const Flexible(
                  flex: 1, child: SizedBox()), //color: Color(0xFF2FBE71),
              Flexible(
                  flex: 10,
                  child: DialogButton(
                    text: 'Save',
                    color: const Color(0xFF2FBE71),
                    onPressed: onSaveButtonTap,
                  )),
            ],
          )
        ]),
      ),
    );
  }
}
