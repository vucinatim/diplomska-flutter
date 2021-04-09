import 'dart:math';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_menu_flutter/src/blocs/restaurants_bloc/restaurants_bloc.dart';
import 'package:web_menu_flutter/src/models/models.dart';
import 'package:web_menu_flutter/src/ui/pages/home/tabs/restaurants/widgets/restaurant_card_big.dart';
import 'package:web_menu_flutter/src/ui/pages/home/tabs/restaurants/widgets/restaurant_item.dart';
import 'package:web_menu_flutter/src/ui/utils/ui_helpers.dart';

class RestaurantsTab extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RestaurantsTabState();
}

const double customToolBarHeight = kToolbarHeight + 14;

class _RestaurantsTabState extends State<RestaurantsTab> {
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RestaurantsBloc, RestaurantsState>(
      listener: (_, RestaurantsState state) {
        if (state is RestaurantsLoaded) {
          _scrollController.jumpTo(0);
        }
      },
      builder: (BuildContext context, RestaurantsState state) {
        return Stack(
          children: <Widget>[
            CustomScrollView(
              controller: _scrollController,
              slivers: <Widget>[
                SliverPersistentHeader(
                  floating: true,
                  delegate: FloatingSearchBarHeader(
                    searchController: _searchController,
                    minExtent: MediaQuery.of(context).padding.top +
                        customToolBarHeight,
                    maxExtent: MediaQuery.of(context).padding.top +
                        customToolBarHeight,
                    // maxExtent:
                    //     MediaQuery.of(context).padding.top + 2 * customToolBarHeight,
                  ),
                ),
                SliverToBoxAdapter(
                  child: Visibility(
                    visible: state is RestaurantsLoaded,
                    child: const Padding(
                      padding: EdgeInsets.fromLTRB(
                        horizontalAppPadding,
                        0,
                        horizontalAppPadding,
                        10,
                      ),
                      child: Text(
                        'Restaurants',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        ),
                      ),
                    ),
                  ),
                ),
                state is RestaurantsLoading
                    ? const SliverFillRemaining(
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      )
                    : state is RestaurantsLoaded
                        ? SliverList(
                            delegate: SliverChildListDelegate(
                              state.restaurants
                                  .map((Restaurant r) =>
                                      RestaurantItem(restaurant: r))
                                  .toList(),
                            ),
                          )
                        : const SliverFillRemaining(
                            child: Center(
                              child: Text('No Items'),
                            ),
                          ),
              ],
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                height: MediaQuery.of(context).padding.top,
                color: Theme.of(context).scaffoldBackgroundColor,
              ),
            ),
          ],
        );
      },
    );
  }
}

class SearchBarHeader extends SliverPersistentHeaderDelegate {
  SearchBarHeader(
      {required this.minExtent,
      required this.maxExtent,
      required this.searchController});

  @override
  final double minExtent;
  @override
  final double maxExtent;

  final TextEditingController searchController;
  static const double searchBarRadius = 4;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final Color bgColor = Color.lerp(Theme.of(context).scaffoldBackgroundColor,
        Colors.white, Curves.easeOutExpo.transform(shrinkRatio(shrinkOffset)))!;

    final double bottomOpacity = lerpDouble(
        0, 1, Curves.easeInCirc.transform(minToMaxShrinkRatio(shrinkOffset)))!;

    return AppBar(
      automaticallyImplyLeading: false,
      elevation: shrinkRatio(shrinkOffset) * 3,
      backgroundColor: bgColor,
      titleSpacing: 0,
      toolbarHeight: customToolBarHeight,
      leading: const Opacity(
        opacity: 0.7,
        child: Icon(
          Icons.search,
          color: Colors.black,
        ),
      ),
      title: TextField(
        controller: searchController,
        decoration: const InputDecoration(
          border: InputBorder.none,
          isDense: true,
          hintText: 'Search...',
          hintStyle: TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
        onChanged: (String searchEntry) {
          BlocProvider.of<RestaurantsBloc>(context)
              .add(SearchRestaurants(searchEntry));
        },
      ),
      actions: <Widget>[
        Opacity(
          opacity: 0.7,
          child: IconButton(
            splashRadius: 5,
            padding: EdgeInsets.zero,
            icon: Icon(
              searchController.value.text.isNotEmpty
                  ? Icons.cancel
                  : Icons.cancel_outlined,
              color: Colors.black,
              size: 22,
            ),
            onPressed: () {
              if (searchController.value.text.isNotEmpty) {
                searchController.clear();
                BlocProvider.of<RestaurantsBloc>(context)
                    .add(LoadRestaurants());
              }
            },
          ),
        ),
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(customToolBarHeight),
        child: ClipRect(
          child: Align(
            alignment: AlignmentDirectional.bottomCenter,
            heightFactor: minToMaxShrinkRatio(shrinkOffset),
            child: Opacity(
              opacity: bottomOpacity,
              child: Container(
                height: customToolBarHeight,
                padding: const EdgeInsets.symmetric(
                    horizontal: horizontalAppPadding),
                child: Column(
                  children: <Widget>[
                    Divider(
                      height: 0.5,
                      thickness: 1,
                      color: Colors.grey.withOpacity(0.4),
                    ),
                    verticalSpaceTiny,
                    TextButton(
                      style: ButtonStyle(
                        visualDensity: VisualDensity.compact,
                        textStyle: MaterialStateProperty.all(
                          const TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 12,
                          ),
                        ),
                        overlayColor:
                            MaterialStateProperty.all(Colors.transparent),
                      ),
                      onPressed: () {},
                      child: Row(
                        children: <Widget>[
                          Text(
                            'Search in area ',
                            style: TextStyle(
                              color:
                                  Theme.of(context).textTheme.bodyText1!.color,
                            ),
                          ),
                          const Text(
                            'Ljubljana',
                          ),
                          const Icon(Icons.keyboard_arrow_down),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  double shrinkRatio(double shrinkOffset) {
    return max(0.0, shrinkOffset) / maxExtent;
  }

  double minToMaxShrinkRatio(double shrinkOffset) {
    return max(0, 1.0 - max(0.0, shrinkOffset) / (maxExtent - minExtent));
  }

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}

/// Alternative transparent search bar

class FloatingSearchBarHeader extends SliverPersistentHeaderDelegate {
  FloatingSearchBarHeader({
    required this.minExtent,
    required this.maxExtent,
    required this.searchController,
  });

  @override
  final double minExtent;
  @override
  final double maxExtent;

  static const double searchBarRadius = 4;
  final TextEditingController searchController;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      child: Card(
        margin: EdgeInsets.fromLTRB(
          horizontalAppPadding,
          MediaQuery.of(context).padding.top + 10,
          horizontalAppPadding,
          10,
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
        ),
        elevation: 3,
        child: Row(
          children: <Widget>[
            Opacity(
              opacity: 0.7,
              child: IconButton(
                splashRadius: 15,
                // visualDensity: VisualDensity.compact,
                padding: EdgeInsets.zero,
                icon: Icon(
                  Icons.search,
                  color: Theme.of(context).primaryColor,
                  size: 22,
                ),
                onPressed: () {
                  if (searchController.value.text.isNotEmpty) {
                    BlocProvider.of<RestaurantsBloc>(context)
                        .add(SearchRestaurants(searchController.value.text));
                  }
                },
              ),
            ),
            Expanded(
              child: TextField(
                textAlignVertical: TextAlignVertical.center,
                controller: searchController,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  isDense: true,
                  hintText: 'Search...',
                  hintStyle: TextStyle(
                    fontWeight: FontWeight.w600,
                    // color: Theme.of(context).primaryColor.withOpacity(0.7),
                  ),
                ),
                onChanged: (String searchEntry) {
                  BlocProvider.of<RestaurantsBloc>(context)
                      .add(SearchRestaurants(searchEntry));
                },
              ),
            ),
            Opacity(
              opacity: 0.7,
              child: IconButton(
                splashRadius: 15,
                // visualDensity: VisualDensity.compact,
                padding: EdgeInsets.zero,
                icon: Icon(
                  searchController.value.text.isNotEmpty
                      ? Icons.cancel
                      : Icons.cancel_outlined,
                  // color: Theme.of(context).primaryColor,
                  size: 22,
                ),
                onPressed: () {
                  if (searchController.value.text.isNotEmpty) {
                    searchController.clear();
                    BlocProvider.of<RestaurantsBloc>(context)
                        .add(LoadRestaurants());
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  double shrinkRatio(double shrinkOffset) {
    return 1.0 - max(0.0, shrinkOffset) / maxExtent;
  }

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
