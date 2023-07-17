import 'dart:ui';

import 'package:uuid/uuid.dart';

class Note {
  final String id;
  String title;
  String content;
  final Color color;

  Note({required this.content, required this.title, required this.color})
      : id = const Uuid().v4();
}
