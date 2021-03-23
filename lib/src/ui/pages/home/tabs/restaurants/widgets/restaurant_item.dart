import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:web_menu_flutter/src/app/routing/router.dart';
import 'package:web_menu_flutter/src/models/models.dart';
import 'package:web_menu_flutter/src/ui/pages/restaurant/restaurant_menu_page.dart';
import 'package:web_menu_flutter/src/ui/utils/ui_helpers.dart';
import 'package:web_menu_flutter/src/app/extensions/hover_extensions.dart';

class RestaurantItem extends StatelessWidget {
  const RestaurantItem({Key? key, this.restaurant}) : super(key: key);

  final Restaurant? restaurant;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(AppRouter.RestaurantRoute,
            arguments: RestaurantArguments(restaurant!.id));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: horizontalAppPadding),
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
                    child: Image.network(restaurant!.imageUrl!),
                  ),
                ),
                horizontalSpaceModerate,
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        restaurant!.name!,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      verticalSpaceTiny,
                      Text(
                        restaurant!.description!,
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
            const Divider(
              height: 20,
              color: Colors.black26,
            ),
          ],
        ),
      ),
    ).showCursorOnHover;
  }
}
