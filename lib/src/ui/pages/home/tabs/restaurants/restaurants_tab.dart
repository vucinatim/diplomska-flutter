import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_menu_flutter/src/blocs/restaurants_bloc/restaurants_bloc.dart';
import 'package:web_menu_flutter/src/models/models.dart';
import 'package:web_menu_flutter/src/ui/pages/home/tabs/restaurants/widgets/restaurant_item.dart';
import 'package:web_menu_flutter/src/ui/utils/ui_helpers.dart';
import 'package:web_menu_flutter/src/ui/widgets/search_bar.dart';

class RestaurantsTab extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RestaurantsTabState();
}

class _RestaurantsTabState extends State<RestaurantsTab> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RestaurantsBloc, RestaurantsState>(
        builder: (BuildContext context, RestaurantsState state) {
      return CustomScrollView(
        slivers: <Widget>[
          SliverPersistentHeader(
            pinned: true,
            delegate: SearchBarHeader(
              searchController: searchController,
              minExtent: MediaQuery.of(context).padding.top + kToolbarHeight,
              maxExtent:
                  MediaQuery.of(context).padding.top + 2 * kToolbarHeight,
            ),
          ),
          const SliverToBoxAdapter(
            child: verticalSpaceModerate,
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
                            .map(
                                (Restaurant r) => RestaurantItem(restaurant: r))
                            .toList(),
                      ),
                    )
                  : const SliverFillRemaining(
                      child: Center(
                        child: Text('No Items'),
                      ),
                    ),
        ],
      );
    });
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
      elevation: shrinkOffset > 0 ? null : 0,
      backgroundColor: bgColor,
      titleSpacing: 0,
      toolbarHeight: kToolbarHeight,
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
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: ClipRect(
          child: Align(
            alignment: AlignmentDirectional.bottomCenter,
            heightFactor: minToMaxShrinkRatio(shrinkOffset),
            child: Opacity(
              opacity: bottomOpacity,
              child: Container(
                height: kToolbarHeight,
                padding: const EdgeInsets.symmetric(
                    horizontal: horizontalAppPadding),
                child: Column(
                  children: <Widget>[
                    const Divider(
                      height: 1,
                      thickness: 1,
                    ),
                    verticalSpaceTiny,
                    TextButton(
                      style: ButtonStyle(
                        visualDensity: VisualDensity.compact,
                        textStyle: MaterialStateProperty.all(
                          const TextStyle(
                            fontWeight: FontWeight.normal,
                          ),
                        ),
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

// class TransparentSearchBarHeader extends SliverPersistentHeaderDelegate {
//   static const double searchBarRadius = 4;
//   @override
//   Widget build(
//       BuildContext context, double shrinkOffset, bool overlapsContent) {
//     return Padding(
//       padding: const EdgeInsets.fromLTRB(10, 35, 10, 10),
//       child: ClipRRect(
//         borderRadius: BorderRadius.circular(searchBarRadius),
//         child: BackdropFilter(
//           filter: ImageFilter.blur(
//             sigmaX: shrinkRatio(shrinkOffset) * 8,
//             sigmaY: shrinkRatio(shrinkOffset) * 8,
//           ),
//           child: SearchBar(
//             borderRadius: searchBarRadius,
//             onSearchChanged: (String searchEntry) {
//               BlocProvider.of<RestaurantsBloc>(context)
//                   .add(SearchRestaurants(searchEntry));
//             },
//             onSearchCleared: () {
//               BlocProvider.of<RestaurantsBloc>(context).add(LoadRestaurants());
//             },
//           ),
//         ),
//       ),
//     );
//   }
//
//   double shrinkRatio(double shrinkOffset) {
//     return 1.0 - max(0.0, shrinkOffset) / maxExtent;
//   }
//
//   @override
//   double get maxExtent => 90;
//
//   @override
//   double get minExtent => 90;
//
//   @override
//   bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
// }
