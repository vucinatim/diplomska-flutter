import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_menu_flutter/src/blocs/restaurant_bloc/restaurant_bloc.dart';
import 'package:web_menu_flutter/src/models/models.dart';
import 'package:web_menu_flutter/src/ui/pages/restaurant/widgets/restaurant_app_bar.dart';
import 'package:web_menu_flutter/src/ui/pages/restaurant/widgets/restaurant_header.dart';
import 'package:web_menu_flutter/src/ui/pages/restaurant/widgets/restaurant_menu.dart';

import 'widgets/categories_tab_bar.dart';

class RestaurantArguments {
  final String? restaurantId;

  RestaurantArguments(this.restaurantId);
}

class RestaurantMenuPage extends StatefulWidget {
  const RestaurantMenuPage({Key? key, this.restaurantId}) : super(key: key);

  final String? restaurantId;

  @override
  State<StatefulWidget> createState() => _RestaurantMenuPageState();
}

class _RestaurantMenuPageState extends State<RestaurantMenuPage>
    with TickerProviderStateMixin {
  static const double _kExpandedHeight = 220.0;
  static const double _kTabBarHeight = 40.0;
  double _tabBarComeInOffset = 200; // re-calculated after first frame

  final ScrollController _scrollController = ScrollController();
  final GlobalKey _endOfHeaderKey = GlobalKey(debugLabel: 'endOfHeaderKey');
  TabController? _tabController;
  List<GlobalKey> _tabKeys = <GlobalKey>[];
  bool _disableScrollListener = false;

  @override
  void initState() {
    BlocProvider.of<RestaurantBloc>(context)
        .add(LoadRestaurant(widget.restaurantId));

    _scrollController.addListener(() {
      if (!_disableScrollListener) {
        if (_tabKeys.every((GlobalKey key) => key.currentContext != null)) {
          final double offset = _scrollController.offset;
          int? closestTabIndex;
          double closestDistance = double.maxFinite;
          for (int i = 0; i < _tabKeys.length; i++) {
            final RenderObject object =
                _tabKeys[i].currentContext!.findRenderObject()!;
            final RenderAbstractViewport viewport =
                RenderAbstractViewport.of(object)!;
            final double target = viewport
                .getOffsetToReveal(object, 0.0)
                .offset
                .clamp(_scrollController.position.minScrollExtent,
                    _scrollController.position.maxScrollExtent);

            final double distance = (offset - target).abs();
            if (distance < closestDistance) {
              closestTabIndex = i;
              closestDistance = distance;
            }
          }

          /// Animate to the closest computed tab if not already there
          if (_tabController!.index != closestTabIndex) {
            _tabController!.animateTo(closestTabIndex!);
          }
        }
      }
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void computeTabBarComeInOffset() {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      final RenderObject object =
          _endOfHeaderKey.currentContext!.findRenderObject()!;
      final RenderAbstractViewport viewport =
          RenderAbstractViewport.of(object)!;
      final double target = viewport
          .getOffsetToReveal(object, 0.0)
          .offset
          .clamp(_scrollController.position.minScrollExtent,
              _scrollController.position.maxScrollExtent);

      setState(() {
        _tabBarComeInOffset = target - 2 * _kTabBarHeight;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<RestaurantBloc, RestaurantState>(
        listener: (BuildContext context, RestaurantState state) {
          if (state is RestaurantLoaded)
            setState(() {
              _tabController = TabController(
                  length: state.restaurant.menu!.length, vsync: this);
              _tabKeys = List<GlobalKey>.generate(state.restaurant.menu!.length,
                  (int index) => GlobalKey(debugLabel: 'tabKey $index'));
              computeTabBarComeInOffset();
            });
        },
        builder: (BuildContext context, RestaurantState state) {
          final Restaurant? restaurant =
              state is RestaurantLoaded ? state.restaurant : null;
          final bool isLoading = state is RestaurantLoading;

          /// --- TabBar Sizing ---
          final double minExtentWithoutTabBar =
              MediaQuery.of(context).padding.top + kToolbarHeight;
          final double minSize = !_scrollController.hasClients ||
                  _scrollController.offset < _tabBarComeInOffset
              ? minExtentWithoutTabBar
              : minExtentWithoutTabBar +
                  min(_kTabBarHeight,
                      _scrollController.offset - _tabBarComeInOffset);
          final double tabBarHeightFactor =
              (minSize - minExtentWithoutTabBar) / _kTabBarHeight;

          return CustomScrollView(
            controller: _scrollController,
            slivers: <Widget>[
              SliverPersistentHeader(
                pinned: true,
                delegate: RestaurantAppBar(
                  minExtent: minSize,
                  maxExtent: _kExpandedHeight,
                  restaurant: restaurant,
                  tabBar: _tabController != null && restaurant != null
                      ? CategoriesTabBar(
                          categories: restaurant.menu,
                          tabController: _tabController,
                          maxHeight: _kTabBarHeight,
                          heightFactor: tabBarHeightFactor,
                          onTabSelected: (int index) {
                            /// Shortly disable auto tab switching for less jitter
                            if (_disableScrollListener == false) {
                              _disableScrollListener = true;
                              Future<void>.delayed(
                                  const Duration(milliseconds: 400), () {
                                _disableScrollListener = false;
                              });
                            }
                            _scrollController.position.ensureVisible(
                              _tabKeys[index]
                                  .currentContext!
                                  .findRenderObject()!,
                              alignment: 0.0,
                              duration: const Duration(milliseconds: 300),
                            );
                          },
                        )
                      : null,
                ),
              ),
              isLoading
                  ? const SliverFillRemaining(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    )
                  : restaurant != null
                      ? SliverToBoxAdapter(
                          child: Column(
                            children: <Widget>[
                              RestaurantHeader(
                                restaurant: restaurant,
                              ),
                              Divider(key: _endOfHeaderKey),
                            ],
                          ),
                        )
                      : const SliverFillRemaining(
                          child: Center(
                            child: Text('Couldn\'t load restaurant'),
                          ),
                        ),
              restaurant?.menu != null && _tabKeys.isNotEmpty
                  ? RestaurantMenu(
                      menu: restaurant!.menu,
                      tabKeys: _tabKeys,
                    )
                  : SliverToBoxAdapter(
                      child: Container(),
                    ),
              SliverToBoxAdapter(
                child: Container(height: 100),
              ),
            ],
          );
        },
      ),
    );
  }
}
