








import 'package:flutter/material.dart';
import 'package:flutter_rest_api_example/bloc/BLoC/bloc_provider.dart';
import 'package:flutter_rest_api_example/bloc/BLoC/location_bloc.dart';

class RestaurantFinder extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return BlockProvider<LocationBloc>(
      bloc: LocationBloc(),
      child: BlockProvider<>,
    )
  }

}