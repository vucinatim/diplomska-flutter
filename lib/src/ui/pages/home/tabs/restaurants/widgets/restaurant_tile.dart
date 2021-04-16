import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:web_menu_flutter/src/models/models.dart';
import 'package:web_menu_flutter/src/ui/utils/ui_helpers.dart';
import 'package:web_menu_flutter/src/app/extensions/hover_extensions.dart';

class RestaurantTile extends StatelessWidget {
  const RestaurantTile({Key? key, this.restaurant}) : super(key: key);

  final Restaurant? restaurant;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
      clipBehavior: Clip.antiAlias,
      child: Container(
        padding: const EdgeInsets.only(right: 10),
        child: Row(
          children: <Widget>[
            Container(
              width: 80,
              height: 80,
              child: FittedBox(
                fit: BoxFit.cover,
                clipBehavior: Clip.antiAlias,
                child: Image.network(restaurant!.thumbnail!),
              ),
            ),
            horizontalSpaceMedium,
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
      ),
    ).showCursorOnHover;
  }
}
