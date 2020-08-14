import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rest_api_example/bloc/BLoC/bloc_provider.dart';
import 'package:flutter_rest_api_example/bloc/BLoC/favourite_bloc.dart';
import 'package:flutter_rest_api_example/bloc/pojo/restaurant.dart';
import 'package:flutter_rest_api_example/bloc/utils/image_container.dart';

class RestaurantDetailsScreen extends StatelessWidget {
  final Restaurant restaurant;

  const RestaurantDetailsScreen({Key key, this.restaurant}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(restaurant.name),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          buildBanner(),
          Padding(
            padding: EdgeInsets.all(8),
            child: Column(
              children: <Widget>[
                Text(
                  restaurant.cuisines,
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  restaurant.address,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w100),
                )
              ],
            ),
          ),
          _buildDetails(context),
          _buildFavoriteButton(context)
        ],
      ),
    );
  }

  Widget buildBanner() {
    return ImageContainer(
      height: 200,
      url: restaurant.imageUrl,
    );
  }

  Widget _buildDetails(BuildContext context) {
    final style = TextStyle(fontSize: 16);
    return Padding(
      padding: EdgeInsets.only(left: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(
            'Price ${restaurant.priceDisplay}',
            style: style,
          ),
          SizedBox(width: 40),
          Text(
            'Rating: ${restaurant.rating.average}',
            style: style,
          ),
        ],
      ),
    );
  }

  Widget _buildFavoriteButton(BuildContext context) {
    final bloc = BlockProvider.of<FavoriteBlock>(context);
    return StreamBuilder<List<Restaurant>>(
      stream: bloc.favoriteStream,
      initialData: bloc.favourite,
      builder: (context, snapshot) {
        List<Restaurant> favorites =
            (snapshot.connectionState == ConnectionState.waiting)
                ? bloc.favourite
                : snapshot.data;

        bool isFavorite = favorites.contains(restaurant);

        return FlatButton.icon(
            onPressed: () => bloc.toggleRestaurant(restaurant),
            icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border),
            label: Text('Favorite'),
            textColor: isFavorite ? Theme.of(context).accentColor : null);
      },
    );
  }
}
