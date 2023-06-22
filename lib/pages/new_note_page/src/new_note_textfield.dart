import 'package:flutter/material.dart';

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
    final double fontSize;
    final String hintText;
    final double? textHeight;

    switch (widget._type) {
      case _TextFieldType.title:
        fontSize = 42;
        hintText = 'Title';
        textHeight = 1.2;

        break;
      case _TextFieldType.content:
        fontSize = 18;
        hintText = 'Type something...';
        textHeight = 1.8;

        break;
    }
    return TextField(
      strutStyle: StrutStyle(height: textHeight),
      controller: widget.controller,
      cursorColor: Colors.white,
      maxLines: null,
      style: TextStyle(
        fontSize: fontSize,
        color: Colors.white,
        //height: textHeight,
      ),
      decoration: InputDecoration(
        focusedBorder: InputBorder.none,
        border: InputBorder.none,
        enabledBorder: InputBorder.none,
        isCollapsed: true,
        hintText: hintText,
        hintStyle: TextStyle(
            fontSize: fontSize,
            color: const Color(0xFF9A9A9A),
            height: textHeight),
      ),
    );
  }
}
