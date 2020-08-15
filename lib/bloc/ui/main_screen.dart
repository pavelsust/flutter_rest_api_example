import 'package:flutter/cupertino.dart';
import 'package:flutter_rest_api_example/bloc/BLoC/bloc_provider.dart';
import 'package:flutter_rest_api_example/bloc/BLoC/location_bloc.dart';
import 'package:flutter_rest_api_example/bloc/pojo/location.dart';
import 'package:flutter_rest_api_example/bloc/ui/location_screen.dart';
import 'package:flutter_rest_api_example/bloc/ui/restaurant_screen.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<LocationBloc>(context);
    return StreamBuilder<Location>(
      stream: bloc.locationStream,
      builder: (context, snapshot){
        final location = snapshot.data;

        if(location == null){
          return LocationScreen();
        }
        return RestaurantScreen();
      },
    );
  }
}
