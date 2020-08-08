import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_rest_api_example/models/NoteForListing.dart';
import 'package:flutter_rest_api_example/services/NoteService.dart';
import 'package:get_it/get_it.dart';

import '../models/NoteForListing.dart';
import '../models/NoteForListing.dart';

class NoteModify extends StatefulWidget {
  var noteForListing;

  NoteModify(this.noteForListing);

  @override
  State<StatefulWidget> createState() {
    return _NoteModify(this.noteForListing);
  }
}

class _NoteModify extends State<NoteModify> {
  var titleController = TextEditingController();
  var noteContentController = TextEditingController();
  var noteForListing;

  _NoteModify(this.noteForListing);

  bool get isEditing => noteForListing.noteId != null;

  NoteService get noteService => GetIt.I<NoteService>();

  var errorMessage;
  var singleNote;
  var isLoading = false;


  @override
  void initState() {
    if (isEditing) {
      setState(() {
        isLoading = true;
      });
      noteService.getSingleNote(noteForListing.noteId).then((response) {
        if (response.error) {
          errorMessage = response.errorMessage ?? 'An error occurred';
          debugPrint('$errorMessage');
        } else {
          singleNote = response.data;
          showTextInField(singleNote);
          debugPrint('${singleNote.description}');
        }
        setState(() {
          isLoading = false;
        });
      });
    }
    super.initState();
  }

  void showTextInField(var singleNote) {
    setState(() {
      titleController.text = singleNote.title;
      noteContentController.text = singleNote.description;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (noteForListing.noteId == null) {
      debugPrint('null');
    }

    debugPrint('${noteForListing.noteId}');

    return Scaffold(
      appBar: AppBar(
        title: Text(
          isEditing ? 'Edit Note' : 'Create Note',
        ),
      ),
      body: Builder(
        builder: (context) {

          if(isLoading){
            Center(
              child: CircularProgressIndicator(),
            );
          }

          return Container(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: <Widget>[
                  TextFormField(
                    keyboardType: TextInputType.text,
                    controller: titleController,
                    decoration: InputDecoration(
                      labelText: 'Title',
                      labelStyle: TextStyle(fontSize: 16),
                      hintText: 'title',
                      errorStyle: TextStyle(color: Colors.red, fontSize: 13),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      controller: noteContentController,
                      decoration: InputDecoration(
                        labelText: 'Description',
                        labelStyle: TextStyle(fontSize: 16),
                        hintText: 'description',
                        errorStyle: TextStyle(color: Colors.red, fontSize: 13),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5)),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: double.infinity,
                    height: 50,
                    child: RaisedButton(
                      onPressed: () {
                        if (isEditing) {
                          // update note api
                        } else {
                          // create api call
                        }
                        Navigator.of(context).pop(true);
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                      color: Colors.green,
                      child: Text(
                        'Save',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
