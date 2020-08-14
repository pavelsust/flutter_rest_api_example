import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rest_api_example/bloc/BLoC/bloc_provider.dart';
import 'package:flutter_rest_api_example/bloc/BLoC/location_bloc.dart';
import 'package:flutter_rest_api_example/bloc/BLoC/location_query_bloc.dart';
import 'package:flutter_rest_api_example/bloc/pojo/location.dart';

class LocationScreen extends StatelessWidget {

  final bool isFullScreenDialog;

  const LocationScreen({Key key, this.isFullScreenDialog = false})
      :super(key: key);


  @override
  Widget build(BuildContext context) {
    final bloc = LocationQueryBloc();
    return BlockProvider(
      bloc: bloc,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Where do you want to eat'),
        ),
        body: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(10),
              child: TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter a location'
                ),
                onChanged: (query) => bloc.submitQuery(query),
              ),
            ),
            Expanded(
              child:,
            )
          ],
        ),
      ),
    );
  }

  Widget buildSearchResult(List<Location> results) {
    return ListView.separated(separatorBuilder:
        (BuildContext context, int index) => Divider()
        , itemCount: results.length, itemBuilder: (context, index) {
          return ListTile(
            title: Text(results[index].title),
            onTap: (){
              var locationBloc = BlockProvider.
            },
          );
        });
  }

}