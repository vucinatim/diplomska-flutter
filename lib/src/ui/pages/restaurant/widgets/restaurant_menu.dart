import 'package:flutter/material.dart';
import 'package:web_menu_flutter/src/models/models.dart';
import 'package:web_menu_flutter/src/ui/utils/ui_helpers.dart';

import 'menu_item.dart';

class RestaurantMenu extends StatefulWidget {
  const RestaurantMenu({
    Key? key,
    this.menu,
    this.tabKeys,
  }) : super(key: key);

  final List<ItemCategory>? menu;
  final List<GlobalKey>? tabKeys;

  @override
  State<StatefulWidget> createState() => _RestaurantMenuState();
}

class _RestaurantMenuState extends State<RestaurantMenu> {
  MenuItem? _expandedItem;

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          final String category = widget.menu?[index].name ?? '';
          final List<MenuItem> items =
              widget.menu?[index].items ?? <MenuItem>[];
          return Column(
            key: widget.tabKeys != null ? widget.tabKeys![index] : null,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              verticalSpaceMedium,
              Padding(
                padding: const EdgeInsets.fromLTRB(
                    horizontalAppPadding, 0, horizontalAppPadding, 5),
                child: Text(
                  category.toUpperCase(),
                  style: const TextStyle(
                      fontSize: 17, fontWeight: FontWeight.w900),
                ),
              ),
              verticalSpaceTiny,
              ...List<Widget>.generate(
                items.length,
                (int index) => ExpandableMenuItem(
                  item: items[index],
                  isExpanded: items[index] == _expandedItem,
                  onTap: () {
                    setState(() {
                      if (items[index] != _expandedItem) {
                        _expandedItem = items[index];
                        return;
                      }
                      _expandedItem = null;
                    });
                  },
                ),
              ).toList(),
            ],
          );
        },
        childCount: widget.menu!.length,
      ),
    );
  }
}
