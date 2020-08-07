import 'package:flutter_rest_api_example/models/NoteForListing.dart';

class NoteService {
  List<NoteForListing> getNoteList() {
    return [
      new NoteForListing('1', 'Hello 1', DateTime.now(), DateTime.now()),
      new NoteForListing('2', 'Hello 1', DateTime.now(), DateTime.now()),
      new NoteForListing('3', 'Hello 1', DateTime.now(), DateTime.now()),
      new NoteForListing('4', 'Hello 1', DateTime.now(), DateTime.now()),
      new NoteForListing('5', 'Hello 1', DateTime.now(), DateTime.now()),
      new NoteForListing('6', 'Hello 1', DateTime.now(), DateTime.now()),
    ];
  }
}
