import 'package:flutter/material.dart';
import 'package:web_menu_flutter/src/app/routing/router.dart';
import 'package:web_menu_flutter/src/models/models.dart';
import 'package:web_menu_flutter/src/ui/pages/pages.dart';
import 'package:web_menu_flutter/src/ui/utils/ui_helpers.dart';

class RestaurantHeader extends StatelessWidget {
  const RestaurantHeader({
    Key? key,
    required this.restaurant,
  }) : super(key: key);

  final Restaurant restaurant;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: horizontalAppPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          verticalSpaceMedium,
          Text(
            restaurant.name!,
            style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          verticalSpaceModerate,
          Text(restaurant.description!),
          verticalSpaceModerate,
          Row(
            children: <Widget>[
              const Icon(Icons.access_time),
              horizontalSpaceSmall,
              const Expanded(
                child: Text('Open • Closes at 22:00'),
              ),
              TextButton(
                style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all(Size.zero),
                  padding: MaterialStateProperty.all(
                    const EdgeInsets.fromLTRB(8, 5, 8, 5),
                  ),
                  backgroundColor: MaterialStateProperty.all(
                    Theme.of(context).primaryColor.withOpacity(0.1),
                  ),
                  overlayColor: MaterialStateProperty.all(Colors.white24),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
                onPressed: () {
                  Navigator.of(context)
                      .pushNamed(AppRouter.RestaurantInfoRoute);
                },
                child: Text(
                  'More info',
                  style: TextStyle(color: Theme.of(context).primaryColor),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
