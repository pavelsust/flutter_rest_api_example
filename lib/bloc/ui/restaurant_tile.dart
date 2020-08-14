import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rest_api_example/bloc/pojo/restaurant.dart';
import 'package:flutter_rest_api_example/bloc/ui/restaurant_details_page.dart';
import 'package:flutter_rest_api_example/bloc/utils/image_container.dart';

class RestaurantTile extends StatelessWidget {
  final Restaurant restaurant;

  const RestaurantTile({Key key, this.restaurant}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
  }
}
