import 'package:flutter/material.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter_rest_api_example/models/NoteForListing.dart';

class NoteList extends StatelessWidget {


  final note = [
    new NoteForListing('1', 'Hello 1', DateTime.now(), DateTime.now()),
    new NoteForListing('1', 'Hello 1', DateTime.now(), DateTime.now()),
    new NoteForListing('1', 'Hello 1', DateTime.now(), DateTime.now()),
    new NoteForListing('1', 'Hello 1', DateTime.now(), DateTime.now()),
    new NoteForListing('1', 'Hello 1', DateTime.now(), DateTime.now()),
    new NoteForListing('1', 'Hello 1', DateTime.now(), DateTime.now()),
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Note List'),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: Icon(Icons.add),
        ),
        body: ListView.separated(
            itemBuilder: (context, position) {
              return ListTile(
                title: Text(
                  note[position].noteTitle,
                  style: TextStyle(color: Theme.of(context).primaryColor),
                ),
                subtitle: Text(
                  '${note[position].lastEditDateTime}'
                ),
              );
            },
            separatorBuilder: (_, __) => Divider(
                  height: 1,
                  color: Colors.green,
                ),
            itemCount: note.length));
  }
}
