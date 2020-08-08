import 'package:flutter/material.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter_rest_api_example/layout/NoteDelete.dart';
import 'package:flutter_rest_api_example/layout/NoteModify.dart';
import 'package:flutter_rest_api_example/models/ApiResponse.dart';
import 'package:flutter_rest_api_example/models/NoteForListing.dart';
import 'package:flutter_rest_api_example/services/NoteService.dart';
import 'package:get_it/get_it.dart';

class NoteMainList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _NoteMainList();
  }
}

class _NoteMainList extends State<NoteMainList> {
  NoteService get service => GetIt.I<NoteService>();
  ApiResponse<List<NoteForListing>> apiResponse;
  bool isLoading = false;

  var note;

  @override
  void initState() {
    super.initState();
    fetchNote();
  }

  void fetchNote() async {
    setState(() {
      isLoading = true;
    });
    apiResponse = await service.getNoteList();
    note = apiResponse.data;
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Note List'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          openNoteModify(context, NoteForListing());
        },
        child: Icon(Icons.add),
      ),
      body: Builder(
        builder: (_) {
          if (isLoading) {
            return Container(
              alignment: Alignment.center,
              child: CircularProgressIndicator(),
            );
          }

          if (apiResponse.error) {
            return Center(
              child: Text(apiResponse.errorMessage),
            );
          }

          return ListView.separated(
              itemBuilder: (context, position) {
                return Dismissible(
                  key: ValueKey(note[position].noteId),
                  direction: DismissDirection.startToEnd,
                  onDismissed: (direction) {
                    note.remove(position);
                  },
                  confirmDismiss: (direction) async {
                    var result = await showDialog(
                        context: context, builder: (_) => NoteDelete());
                    debugPrint('${result.toString()}');
                    return result;
                  },
                  background: Container(
                    color: Colors.red,
                    padding: EdgeInsets.only(left: 16),
                    child: Align(
                        child: Icon(Icons.delete, color: Colors.white),
                        alignment: Alignment.centerLeft),
                  ),
                  child: ListTile(
                    title: Text(
                      note[position].noteTitle,
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    ),
                    onTap: () {
                      openNoteModify(context, note[position]);
                    },
                    subtitle: Text(
                        '${note[position].createdDateTime == null ? 'nothing': note[position].createdDateTime}'),
                  ),
                );
              },
              separatorBuilder: (_, __) => Divider(
                    height: 1,
                    color: Colors.green,
                  ),
              itemCount: note.length);
        },
      ),
    );
  }
}

void openNoteModify(BuildContext context, var note) {
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => NoteModify(note)));
}
