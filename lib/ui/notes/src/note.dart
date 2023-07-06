import 'package:uuid/uuid.dart';

class Note {
  final String id;
  String title;
  String content;

  Note({required this.content, required this.title}) : id = const Uuid().v4();
}
