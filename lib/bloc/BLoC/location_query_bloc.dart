import 'dart:async';

import 'package:flutter_rest_api_example/bloc/BLoC/bloc.dart';
import 'package:flutter_rest_api_example/bloc/pojo/location.dart';
import 'package:flutter_rest_api_example/bloc/pojo/zomato_client.dart';

class LocationQueryBloc extends Bloc {
  final _controller = StreamController<List<Location>>();
  final _client = ZomatoClient();

  Stream<List<Location>> get locationStream => _controller.stream;

  void submitQuery(String query) async {
    final result = await _client
        .fetchLocations(query)
        .then((value) => _controller.sink.add(value));
  }

  @override
  void dispose() {
    _controller.close();
    // TODO: implement dispose
  }
}
