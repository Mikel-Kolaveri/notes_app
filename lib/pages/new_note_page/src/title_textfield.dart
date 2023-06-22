import 'package:flutter/material.dart';

// class TitleTextField extends StatefulWidget {
//   const TitleTextField({super.key});

//   @override
//   State<TitleTextField> createState() => _TitleTextFieldState();
// }

// class _TitleTextFieldState extends State<TitleTextField> {
//   @override
//   Widget build(BuildContext context) {
//     return const TextField(
//       cursorColor: Colors.white,
//       cursorHeight: 42,
//       maxLines: null,
//       style: TextStyle(fontSize: 42, color: Colors.white, height: 1),
//       decoration: InputDecoration(
//         focusedBorder: InputBorder.none,
//         border: InputBorder.none,
//         enabledBorder: InputBorder.none,
//         filled: true,
//         hintText: 'Title',
//         hintStyle: TextStyle(fontSize: 42, color: Color(0xFF9A9A9A), height: 1),
//       ),
//     );
//   }
// }

enum _TextFieldType { title, content }

class NewNoteTextField extends StatefulWidget {
  const NewNoteTextField.title({super.key, required this.controller})
      : _type = _TextFieldType.title;
  const NewNoteTextField.content({super.key, required this.controller})
      : _type = _TextFieldType.content;

  final _TextFieldType _type;
  final TextEditingController controller;

  @override
  State<NewNoteTextField> createState() => _NewNoteTextFieldState();
}

class _NewNoteTextFieldState extends State<NewNoteTextField> {
  @override
  Widget build(BuildContext context) {
    double fontSize;
    final String hintText;
    switch (widget._type) {
      case _TextFieldType.title:
        fontSize = 42;
        hintText = 'Title';
        break;
      case _TextFieldType.content:
        fontSize = 18;
        hintText = 'Type something...';
        break;
    }
    return TextField(
      controller: widget.controller,
      cursorColor: Colors.white,
      cursorHeight: fontSize,
      maxLines: null,
      style: TextStyle(fontSize: fontSize, color: Colors.white, height: 1.02),
      decoration: InputDecoration(
        focusedBorder: InputBorder.none,
        border: InputBorder.none,
        enabledBorder: InputBorder.none,
        // filled: true,
        hintText: hintText,
        hintStyle: TextStyle(
            fontSize: fontSize, color: const Color(0xFF9A9A9A), height: 1.02),
      ),
    );
  }
}
