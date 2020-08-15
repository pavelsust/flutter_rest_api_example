import 'package:flutter/material.dart';
import 'package:flutter_rest_api_example/bloc/BLoC/bloc_provider.dart';
import 'package:flutter_rest_api_example/bloc/BLoC/favourite_bloc.dart';
import 'package:flutter_rest_api_example/bloc/pojo/restaurant.dart';
import 'package:flutter_rest_api_example/bloc/ui/restaurant_details_page.dart';
import 'package:flutter_rest_api_example/bloc/utils/image_container.dart';

class FavoriteScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _FavoriteScreen();
  }
}

class _FavoriteScreen extends State<FavoriteScreen> {
  @override
  Widget build(BuildContext context) {
    var bloc = BlocProvider.of<FavoriteBlock>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Favourite'),
      ),
      body: StreamBuilder<List<Restaurant>>(
        stream: bloc.favoriteStream,
        initialData: bloc.favourite,
        builder: (context, snapshot) {
          List<Restaurant> favorites =
              (snapshot.connectionState == ConnectionState.waiting)
                  ? bloc.favourite
                  : snapshot.data;
          if (favorites == null || favorites.isEmpty) {
            return Center(
              child: Text('No Favoites'),
            );
          }

          return ListView.separated(
              itemBuilder: (context, index) {
                final restaurant = favorites[index];
                return ListTile(
                  leading: ImageContainer(
                    width: 50,
                    height: 50,
                    url: restaurant.thumbUrl,
                  ),
                  title: Text(restaurant.name),
                  trailing: Icon(Icons.keyboard_arrow_right),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            RestaurantDetailsScreen(restaurant: restaurant)));
                  },
                );
              },
              separatorBuilder: (context, index) => Divider(),
              itemCount: favorites.length);
        },
      ),
    );
  }
}
