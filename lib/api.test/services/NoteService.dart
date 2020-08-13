import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_rest_api_example/api.test/models/ApiResponse.dart';
import 'package:flutter_rest_api_example/api.test/models/NoteForListing.dart';
import 'package:flutter_rest_api_example/api.test/models/SingleNote.dart';
import 'package:http/http.dart' as http;

class NoteService {
  static const BASE_URL = 'http://192.168.0.101:7000/api/note/';
  static const headers = {'Content-Type': 'application/json'};

  Future<ApiResponse<SingleNote>> getSingleNote(noteId) {
    return http.get(BASE_URL + '/note/' + noteId).then((value) {
      if (value.statusCode == 200) {
        var jsonData = json.decode(value.body);
        var note = SingleNote(
            id: jsonData['_id'],
            title: jsonData['title'],
            description: jsonData['description']);
        return ApiResponse<SingleNote>(data: note);
      } else {
        return ApiResponse<SingleNote>(
            error: true, errorMessage: 'An error occured');
      }
    }).catchError((onError) {
      return ApiResponse<SingleNote>(error: true, errorMessage: onError);
    });
  }

  Future<ApiResponse<bool>> createNote(var noteInsert) {
    return http
        .post(BASE_URL + 'add',
            headers: headers, body: json.encode(noteInsert.toJson()))
        .then((value) {
      if (value.statusCode == 200) {
        return ApiResponse<bool>(data: true);
      } else {
        return ApiResponse<bool>(error: true, errorMessage: 'An error occured');
      }
    }).catchError((onError) {
      return ApiResponse<bool>(error: true, errorMessage: onError);
    });
  }

  Future<ApiResponse<bool>> updateNote(var noteID, var noteInsert) {
    return http.put(BASE_URL + 'update/' + noteID, headers: headers, body: json.encode(noteInsert.toJson()))
        .then((value) {
      if (value.statusCode == 200) {
        return ApiResponse<bool>(data: true);
      } else {
        return ApiResponse<bool>(error: true, errorMessage: 'An error occured');
      }
    }).catchError((onError) {
      return ApiResponse<bool>(error: true, errorMessage: onError);
    });
  }


  Future<ApiResponse<bool>> deleteNote(var noteID) {

    return http.delete(BASE_URL + 'delete/' + noteID)
        .then((value) {
          debugPrint('Status code ${value.statusCode}');
      if (value.statusCode == 200) {
        return ApiResponse<bool>(data: true);
      } else {
        return ApiResponse<bool>(error: true, errorMessage: 'An error occured');
      }
    }).catchError((onError) {
      return ApiResponse<bool>(error: true, errorMessage: onError);
    });
  }


  Future<ApiResponse<List<NoteForListing>>> getNoteList() {
    return http.get(BASE_URL + 'all').then((value) {
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
