import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_rest_api_example/api.test/models/NoteCreate.dart';
import 'package:flutter_rest_api_example/api.test/services/NoteService.dart';
import 'package:get_it/get_it.dart';

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
          debugPrint('${isLoading.toString()}');
          if (isLoading) {
            return Container(
              alignment: Alignment.center,
              child: CircularProgressIndicator(),
            );
          }
          debugPrint(' call again');

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
                      onPressed: () async {
                        if (isEditing) {
                          // update note api

                          setState(() {
                            isLoading = true;
                          });

                          var note = NoteCreate(
                              titleController.text, noteContentController.text
                          );
                          var result = await noteService.updateNote(
                              noteForListing.noteId, note);
                          setState(() {
                            isLoading = false;
                          });

                          var message = 'Note Update';
                          var text = result.error ? (result.errorMessage ??
                              'An error occrred') : 'Your note updated';
                          _showAlertDialog(message, text);
                        } else {
                          setState(() {
                            isLoading = true;
                          });
                          var note = NoteCreate(
                              titleController.text, noteContentController.text);
                          var result = await noteService.createNote(note);
                          var message = 'Done';

                          var text = result.error
                              ? (result.errorMessage ?? 'An error occurred')
                              : 'Your Note is saved';

                          setState(() {
                            isLoading = false;
                          });

                          showDialog(
                              context: context,
                              builder: (_) =>
                                  AlertDialog(
                                    title: Text(message),
                                    content: Text(text),
                                    actions: <Widget>[
                                      FlatButton(
                                        child: Text('Ok'),
                                        onPressed: () {
                                          debugPrint('click');
                                          Navigator.pop(context);
                                        },
                                      )
                                    ],
                                  )).then((data) {
                            if (result.data) {
                              Navigator.of(context).pop();
                            }
                          });
                        }
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

  void _showAlertDialog(var title, var message) {
    var alertDialog = AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: <Widget>[
        FlatButton(
          child: Text('Ok'),
          onPressed: () {
            Navigator.pop(context);
          },
        )
      ],
    );

    showDialog(context: context, builder: (_) => alertDialog);
  }
}
