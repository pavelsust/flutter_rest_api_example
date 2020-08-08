import 'package:flutter/material.dart';
import 'package:flutter_rest_api_example/layout/NoteList.dart';
import 'package:flutter_rest_api_example/services/NoteService.dart';
import 'package:get_it/get_it.dart';

void main() {
  setupLocator();
  runApp(MyApp());
}

void setupLocator(){
  GetIt.I.registerLazySingleton(() => NoteService());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.blue,
      ),
      home: NoteMainList()
    );
  }
}
