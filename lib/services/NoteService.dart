import 'dart:convert';
import 'dart:html';

import 'package:flutter_rest_api_example/models/ApiResponse.dart';
import 'package:flutter_rest_api_example/models/NoteForListing.dart';
import 'package:http/http.dart' as http;

class NoteService {
  static const BASE_URL = 'http://192.168.0.100:7000/api/note/all';

  Future<ApiResponse<List<NoteForListing>>> getNoteList() {
    return http.get(BASE_URL).then((value) {
      if (value.statusCode == 200) {
        var jsonData = json.decode(value.body);
        var noteList = <NoteForListing>[];
        for (var item in jsonData) {
          var note = NoteForListing(
              noteId: item['_id'],
              noteTitle: item['title'],
              createdDateTime: item['description']);
          noteList.add(note);
        }
        return ApiResponse<List<NoteForListing>>(data: noteList);
      } else {
        return ApiResponse<List<NoteForListing>>(
            error: true, errorMessage: 'An error occured');
      }
    }).catchError((onError) {
      return ApiResponse<List<NoteForListing>>(
          errorMessage: onError.toString(), error: true);
    });
  }
}
