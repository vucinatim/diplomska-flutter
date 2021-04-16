import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_menu_flutter/src/app/routing/router.dart';
import 'package:web_menu_flutter/src/blocs/profile_bloc/profile_bloc.dart';
import 'package:web_menu_flutter/src/models/models.dart';
import 'package:web_menu_flutter/src/ui/pages/restaurant/restaurant_menu_page.dart';
import 'package:web_menu_flutter/src/ui/utils/ui_helpers.dart';
import 'package:web_menu_flutter/src/app/extensions/hover_extensions.dart';
import 'package:web_menu_flutter/src/ui/widgets/favorite_button/favorite_button.dart';
import 'package:web_menu_flutter/src/ui/widgets/favorite_button/restaurant_favorite_button.dart';

class RestaurantItem extends StatelessWidget {
  const RestaurantItem({Key? key, required this.restaurant}) : super(key: key);

  final Restaurant restaurant;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        InkWell(
          onTap: () {
            Navigator.of(context).pushNamed(AppRouter.RestaurantRoute,
                arguments: RestaurantArguments(restaurant.id));
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: horizontalAppPadding, vertical: 5),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      width: 70,
                      height: 70,
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: FittedBox(
                        fit: BoxFit.cover,
                        clipBehavior: Clip.antiAlias,
                        child: Image.network(restaurant.thumbnail!),
                      ),
                    ),
                    horizontalSpaceModerate,
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            restaurant.name!,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          verticalSpaceTiny,
                          Text(
                            restaurant.description!,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontSize: 11),
                          ),
                          verticalSpaceTiny,
                          Opacity(
                            opacity: 0.6,
                            child: Row(
                              children: <Widget>[
                                const Icon(
                                  Icons.location_pin,
                                  size: 13,
                                ),
                                horizontalSpaceTiny,
                                Text(
                                  restaurant.contactInfo!.city!,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(fontSize: 11),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    RestaurantFavoriteButton(restaurant: restaurant),
                  ],
                ),
              ],
            ),
          ),
        ).showCursorOnHover,
        const Divider(
          height: 10,
          indent: 105,
          thickness: 0.2,
          endIndent: horizontalAppPadding,
          color: Colors.grey,
        ),
      ],
    );
  }
}
