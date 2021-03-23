import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:web_menu_flutter/src/models/models.dart';
import 'package:web_menu_flutter/src/ui/utils/ui_helpers.dart';
import 'package:web_menu_flutter/src/ui/widgets/custom_bottom_sheet.dart';
import 'package:web_menu_flutter/src/ui/widgets/custom_icon_button.dart';
import 'package:web_menu_flutter/src/ui/widgets/menu_search_delegate.dart';
import 'package:web_menu_flutter/src/ui/widgets/options_menu.dart';

class RestaurantAppBar extends SliverPersistentHeaderDelegate {
  RestaurantAppBar({
    required this.minExtent,
    required this.maxExtent,
    this.tabBar,
    this.restaurant,
  });
  @override
  final double minExtent;
  @override
  final double maxExtent;

  final Restaurant? restaurant;
  final PreferredSizeWidget? tabBar;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final Color overlayGradientTopColor = Colors.white.withOpacity(lerpDouble(1,
        0.4, Curves.easeOutExpo.transform(minToMaxShrinkRatio(shrinkOffset)))!);

    final Color overlayGradientBottomColor = Colors.white.withOpacity(
        lerpDouble(1, 0,
            Curves.easeOutExpo.transform(minToMaxShrinkRatio(shrinkOffset)))!);

    final double? bgImageScale =
        lerpDouble(1.0, 1.2, shrinkRatio(shrinkOffset));

    final double bgImageOpacity = minToMaxShrinkRatio(shrinkOffset);

    final Color? iconsBgColor =
        ColorTween(begin: Colors.black.withOpacity(0.1), end: Colors.white70)
            .lerp(shrinkRatio(shrinkOffset));

    final Offset tittleOffset = Offset(
        0,
        lerpDouble(
            0, 20, Curves.easeInOut.transform(shrinkRatio(shrinkOffset)))!);

    final Offset searchIconOffset = Offset(
        lerpDouble(
            38,
            0,
            Curves.fastOutSlowIn
                .transform(halfToMaxShrinkRatio(shrinkOffset)))!,
        0);

    final double dotsIconOpacity = halfToMaxShrinkRatio(shrinkOffset);

    final double dotsIconScale =
        Curves.easeInOutQuint.transform(halfToMaxShrinkRatio(shrinkOffset));

    final MenuSearchDelegate<ItemCategory> _searchDelegate =
        MenuSearchDelegate<ItemCategory>(
            items: restaurant?.menu ?? <ItemCategory>[],
            filter: (ItemCategory category, String query) {
              if (category.items!
                  .where((MenuItem item) => item.title!['en']!.contains(query))
                  .isNotEmpty) return true;
              return false;
            });

    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        AppBar(
          automaticallyImplyLeading: false,
          elevation: minToZeroShrinkRatio(shrinkOffset) * 4,
          backgroundColor: Colors.white,
          leadingWidth: 40,
          titleSpacing: 0,
          bottom: tabBar,
          flexibleSpace: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              Opacity(
                opacity: bgImageOpacity,
                child: restaurant?.imageUrl != null
                    ? Transform.scale(
                        scale: bgImageScale!,
                        alignment: Alignment.bottomCenter,
                        child: restaurant?.imageUrl != null
                            ? Image.network(
                                restaurant!.imageUrl!,
                                fit: BoxFit.cover,
                              )
                            : const Text('No Restaurant Image'),
                      )
                    : Container(
                        color: Colors.grey,
                      ),
              ),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: <Color>[
                      overlayGradientTopColor,
                      overlayGradientBottomColor,
                    ],
                    stops: const <double>[0.1, 0.5],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    // tileMode: TileMode.repeated,
                  ),
                ),
              ),
            ],
          ),
          title: Row(
            children: <Widget>[
              horizontalAppPaddingSpace,
              CustomIconButton(
                icon: const Icon(Icons.arrow_back_rounded),
                backgroundColor: iconsBgColor,
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              Transform.translate(
                offset: tittleOffset,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Opacity(
                    opacity: minToZeroShrinkRatio(shrinkOffset),
                    child: Text(
                      restaurant?.name ?? '',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          actions: <Widget>[
            Transform.translate(
              offset: searchIconOffset,
              child: FadeTransition(
                opacity: ReverseAnimation(_searchDelegate.transitionAnimation),
                child: ScaleTransition(
                  scale: ReverseAnimation(CurvedAnimation(
                      parent: _searchDelegate.transitionAnimation,
                      curve: Curves.easeIn)),
                  child: CustomIconButton(
                    icon: const Icon(Icons.search),
                    backgroundColor: iconsBgColor,
                    onPressed: () {
                      showSearch(
                        context: context,
                        delegate: _searchDelegate,
                      );
                    },
                  ),
                ),
              ),
            ),
            horizontalSpaceTiny,
            FadeTransition(
              opacity: ReverseAnimation(_searchDelegate.transitionAnimation),
              child: ScaleTransition(
                scale: ReverseAnimation(CurvedAnimation(
                    parent: _searchDelegate.transitionAnimation,
                    curve: Curves.ease)),
                child: Transform.scale(
                  scale: dotsIconScale,
                  child: Opacity(
                    opacity: dotsIconOpacity,
                    child: OptionsMenu(
                      buttonBackgroundColor: iconsBgColor,
                      options: <MenuOption>[
                        MenuOption(
                            child: Text(
                                'More info about ${restaurant?.name ?? 'this restaurant'}'),
                            onPressed: () {
                              print('SHOW MORE OPTIONS');
                            }),
                        MenuOption(
                            child: const Text('Choose a different language'),
                            onPressed: () {
                              showModalBottomSheet(
                                  context: context,
                                  shape: bottomSheetShape,
                                  builder: (BuildContext bc) {
                                    return CustomBottomSheet(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          const Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 16),
                                            child: Text(
                                              'Language',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20),
                                            ),
                                          ),
                                          verticalSpaceModerate,
                                          Column(
                                            children: List<Widget>.generate(
                                              restaurant!
                                                  .supportedLanguages!.length,
                                              (int index) => ListTile(
                                                title: Text(restaurant!
                                                        .supportedLanguages![
                                                    index]),
                                                trailing:
                                                    const Icon(Icons.check),
                                                selected: true,
                                                onTap: () {
                                                  // do something
                                                },
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  });
                            }),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            horizontalAppPaddingSpace,
          ],
        ),
      ],
    );
  }

  double shrinkRatio(double shrinkOffset) {
    return 1.0 - max(0.0, shrinkOffset) / maxExtent;
  }

  double halfToMaxShrinkRatio(double shrinkOffset) {
    return 1.0 - (max(1.0, max(0.0, shrinkOffset) / (maxExtent / 2)) - 1.0);
  }

  double minToMaxShrinkRatio(double shrinkOffset) {
    return max(0, 1.0 - max(0.0, shrinkOffset) / (maxExtent - minExtent));
  }

  double minToZeroShrinkRatio(double shrinkOffset) {
    return 1.0 - min(1.0, max(0.0, maxExtent - shrinkOffset) / minExtent);
  }

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
