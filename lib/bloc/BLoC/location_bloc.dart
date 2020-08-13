
import 'dart:async';

import 'package:flutter_rest_api_example/bloc/BLoC/bloc.dart';
import 'package:flutter_rest_api_example/bloc/pojo/location.dart';

class LocationBloc implements Bloc{

  Location _location;
  Location get selectedLocation => _location;

  final _locationController = StreamController<Location>();

  Stream<Location> get locationStream => _locationController.stream;


  void selectLocation(Location location){
    _location = location;
    _locationController.sink.add(location);
  }


  @override
  void dispose() {
    // TODO: implement dispose
    _locationController.close();
  }

}