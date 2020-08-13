import 'package:flutter/material.dart';
import 'package:flutter_rest_api_example/bloc/BLoC/bloc_provider.dart';
import 'package:flutter_rest_api_example/bloc/BLoC/favourite_bloc.dart';
import 'package:flutter_rest_api_example/bloc/BLoC/location_bloc.dart';

void main() => runApp(RestaurantFinder());

class RestaurantFinder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlockProvider<LocationBloc>(
        bloc: LocationBloc(),
        child: BlockProvider<FavoriteBlock>(
          bloc: FavoriteBlock(),
          child: MaterialApp(
            title: 'Restaurant Finder',
            theme: ThemeData(
              primarySwatch: Colors.red,
            ),
          ),
        ));
  }
}
