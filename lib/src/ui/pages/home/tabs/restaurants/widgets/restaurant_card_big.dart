import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:web_menu_flutter/src/app/routing/router.dart';
import 'package:web_menu_flutter/src/models/models.dart';
import 'package:web_menu_flutter/src/ui/pages/restaurant/restaurant_menu_page.dart';
import 'package:web_menu_flutter/src/ui/utils/ui_helpers.dart';
import 'package:web_menu_flutter/src/app/extensions/hover_extensions.dart';

class RestaurantCardBig extends StatelessWidget {
  const RestaurantCardBig({Key? key, this.restaurant}) : super(key: key);

  final Restaurant? restaurant;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(
          horizontal: horizontalAppPadding, vertical: 8),
      clipBehavior: Clip.antiAlias,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      elevation: 8,
      child: InkWell(
        onTap: () {
          Navigator.of(context).pushNamed(AppRouter.RestaurantRoute,
              arguments: RestaurantArguments(restaurant!.id));
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              height: 150,
              width: Size.infinite.width,
              child: Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  FittedBox(
                    fit: BoxFit.cover,
                    clipBehavior: Clip.antiAlias,
                    child: Image.network(restaurant!.imageUrl!),
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: IconButton(
                      icon: const Icon(Icons.favorite_border),
                      color: Colors.white,
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ),
            horizontalSpaceMedium,
            Padding(
              padding: EdgeInsets.all(15),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              restaurant!.name!,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            verticalSpaceTiny,
                            Text(
                              restaurant!.description!,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                      horizontalSpaceLarge,
                      Icon(
                        Icons.restaurant,
                        size: 18,
                        color: Theme.of(context).primaryColor,
                      ),
                    ],
                  ),
                  const Divider(
                    height: 18,
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
                          restaurant!.contactInfo!.city!,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontSize: 11),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ).showCursorOnHover;
  }
}
