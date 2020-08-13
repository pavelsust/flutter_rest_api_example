

import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class NoteForListing{
  var noteId;
  var noteTitle;
  var createdDateTime;
  var lastEditDateTime;

  NoteForListing({this.noteId, this.noteTitle, this.createdDateTime, this.lastEditDateTime});

  NoteForListing.Empty();

}