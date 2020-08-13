import 'dart:async';

import 'package:flutter_rest_api_example/bloc/BLoC/bloc.dart';
import 'package:flutter_rest_api_example/bloc/pojo/location.dart';
import 'package:flutter_rest_api_example/bloc/pojo/restaurant.dart';
import 'package:flutter_rest_api_example/bloc/pojo/zomato_client.dart';

class RestaurantBloc implements Bloc {
  final _client = ZomatoClient();
  final _controller = StreamController<List<Restaurant>>();
  final Location location;

  Stream<List<Restaurant>> get stream => _controller.stream;

  RestaurantBloc(this.location);

  void submitQuery(String query) async {
    final result = await _client.fetchRestaurants(location, query);
    _controller.sink.add(result);
  }

  @override
  void dispose() {
    _controller.close();
  }
}
