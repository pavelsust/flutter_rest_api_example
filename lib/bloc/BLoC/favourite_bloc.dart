import 'dart:async';

import 'package:flutter_rest_api_example/bloc/BLoC/bloc.dart';
import 'package:flutter_rest_api_example/bloc/pojo/restaurant.dart';

class FavoriteBlock implements Bloc {
  var _restaurants = <Restaurant>[];

  List<Restaurant> get favourite => _restaurants;

  // ignore: close_sinks
  final _controller = StreamController<List<Restaurant>>.broadcast();

  Stream<List<Restaurant>> get favoriteStream => _controller.stream;

  void toggleRestaurant(Restaurant restaurant){
    if(_restaurants.contains(restaurant)){
      _restaurants.remove(restaurant);
    }else{
      _restaurants.add(restaurant);
    }
    _controller.sink.add(_restaurants);
  }

  @override
  void dispose() {
    _controller.close();
  }
}
