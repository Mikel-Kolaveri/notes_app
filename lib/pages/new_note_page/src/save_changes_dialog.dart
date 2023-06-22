import 'package:flutter/material.dart';
import 'package:notes_app/ui/gap.dart';

class SaveChangesDialog extends StatelessWidget {
  const SaveChangesDialog({super.key});

  @override
  Widget build(BuildContext context) {
    const buttonFont = TextStyle(fontSize: 14, color: Colors.white);
    return Dialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
      backgroundColor: const Color(0xFF252525),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SizedBox(
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
                  child: TextButton(
                      onPressed: () {
                        print('discard');
                      },
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(8),
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(5),
                          ),
                          color: Color(0xFFFF0000),
                        ),
                        child: const Text(
                          'Discard',
                          style: buttonFont,
                          textAlign: TextAlign.center,
                        ),
                      )),
                ),
                const Flexible(flex: 1, child: SizedBox()),
                Flexible(
                  flex: 10,
                  child: TextButton(
                      onPressed: () {},
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(5),
                          ),
                          color: Color(0xFF2FBE71),
                        ),
                        width: double.infinity,
                        child: const Text(
                          'Save',
                          style: buttonFont,
                          textAlign: TextAlign.center,
                        ),
                      )),
                ),
              ],
            )
          ]),
        ),
      ),
    );
  }
}
