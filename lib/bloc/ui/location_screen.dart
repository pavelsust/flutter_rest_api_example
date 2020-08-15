import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rest_api_example/bloc/BLoC/bloc_provider.dart';
import 'package:flutter_rest_api_example/bloc/BLoC/location_bloc.dart';
import 'package:flutter_rest_api_example/bloc/BLoC/location_query_bloc.dart';
import 'package:flutter_rest_api_example/bloc/pojo/location.dart';

class LocationScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    var bloc = LocationQueryBloc();
    return BlocProvider<LocationQueryBloc>(
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
                  hintText: "Enter a location",
                ),
                onChanged: (query) => bloc.submitQuery(query),
              ),
            ),
            Expanded(
              child: _buildResults(bloc),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildResults(LocationQueryBloc bloc) {

    return StreamBuilder<List<Location>>(
      stream: bloc.locationStream,
      builder: (context, snapshot) {
        final result = snapshot.data;
        if (result == null) {
          return Center(child: Text('Enter a location'));
        }
        if (result.isEmpty) {
          return Center(child: Text('Enter a location'));
        }

        return _buildSearchResults(result);
      },
    );
  }

  Widget _buildSearchResults(List<Location> results) {
    return ListView.separated(
        itemBuilder: (context, index) {
          final location = results[index];
          return ListTile(
            title: Text(location.title),
            onTap: () {
              var locationBloc = BlocProvider.of<LocationBloc>(context);
              debugPrint(locationBloc.toString());
            },
          );
        },
        separatorBuilder: (BuildContext context, int index) => Divider(),
        itemCount: results.length);
  }
}
