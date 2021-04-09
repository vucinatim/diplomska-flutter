import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:web_menu_flutter/src/models/models.dart';
import 'package:web_menu_flutter/src/ui/utils/ui_helpers.dart';
import 'package:web_menu_flutter/src/app/extensions/hover_extensions.dart';

class RestaurantCardSmall extends StatelessWidget {
  const RestaurantCardSmall({Key? key, this.restaurant}) : super(key: key);

  final Restaurant? restaurant;

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: EdgeInsets.all(4),
        clipBehavior: Clip.antiAlias,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              height: 100,
              width: Size.infinite.width,
              color: Colors.red,
              child: FittedBox(
                fit: BoxFit.cover,
                clipBehavior: Clip.antiAlias,
                child: Image.network(restaurant!.imageUrl!),
              ),
            ),
            horizontalSpaceMedium,
            Padding(
              padding: EdgeInsets.all(8),
              child: Column(
                mainAxisSize: MainAxisSize.min,
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
                  const Divider(
                    height: 18,
                  ),
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
        )).showCursorOnHover;
  }
}
