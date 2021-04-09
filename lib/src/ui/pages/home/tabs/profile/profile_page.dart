import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_menu_flutter/src/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:web_menu_flutter/src/blocs/profile_bloc/profile_bloc.dart';
import 'package:web_menu_flutter/src/ui/pages/home/tabs/restaurants/widgets/restaurant_card_small.dart';
import 'package:web_menu_flutter/src/ui/utils/ui_helpers.dart';
import 'package:web_menu_flutter/src/ui/widgets/custom_app_bar.dart';
import 'package:web_menu_flutter/src/ui/widgets/custom_button.dart';
import 'package:web_menu_flutter/src/ui/widgets/custom_icon_button.dart';

class ProfilePage extends StatelessWidget {
  String getInitials(String? fullName) {
    final List<String>? words = fullName?.split(' ');
    if (words == null) {
      return '??';
    } else if (words.length == 1) {
      if (words.first.length > 1) {
        return '${words.first[0]}${words.first[1]}';
      } else {
        return '??';
      }
    } else {
      return '${words.first[0]}${words[1][0]}';
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (BuildContext context, ProfileState state) {
        if (state is ProfileNotLoaded) {
          BlocProvider.of<ProfileBloc>(context).add(LoadProfile());
          return const Center(
            child: Text('Could not load your profile'),
          );
        }

        if (state is ProfileLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state is ProfileLoaded) {
          return CustomScrollView(
            slivers: <Widget>[
              SliverPersistentHeader(
                pinned: true,
                delegate: CustomAppBar(
                  minExtent:
                      MediaQuery.of(context).padding.top + kToolbarHeight,
                  maxExtent:
                      MediaQuery.of(context).padding.top + kToolbarHeight,
                  showBackButton: false,
                  title: 'Profile',
                  trailing: CustomIconButton(
                    icon: const Icon(Icons.settings),
                    backgroundColor: Colors.black.withOpacity(0.1),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: horizontalAppPadding, vertical: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Hello, ${state.profile.fullName?.split(' ').first}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 33,
                          color: Colors.black87,
                        ),
                      ),
                      verticalSpaceMedium,
                      Row(
                        children: <Widget>[
                          CircleAvatar(
                            radius: 40,
                            backgroundColor: Theme.of(context).primaryColor,
                            child: Container(
                              width: 100,
                              height: 100,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: LinearGradient(
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter,
                                  colors: <Color>[
                                    Theme.of(context).primaryColor,
                                    Theme.of(context).accentColor,
                                  ],
                                ),
                              ),
                              child: Text(
                                getInitials(state.profile.fullName),
                                style: const TextStyle(
                                    fontSize: 35, color: Colors.white),
                              ),
                            ),
                          ),
                          horizontalSpaceMedium,
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  state.profile.fullName ?? noValueString,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                                verticalSpaceSmall,
                                Text(
                                  state.profile.email ?? noValueString,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black54),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Card(
                  margin: const EdgeInsets.symmetric(
                      horizontal: horizontalAppPadding, vertical: 10),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  // color: Theme.of(context).highlightColor,
                  child: Padding(
                    padding: const EdgeInsets.all(18),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const Text(
                            'Invite friends and earn bonus credit points'),
                        verticalSpaceMedium,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            TextButton(
                              child: const Text('Hide'),
                              style: ButtonStyle(
                                minimumSize:
                                    MaterialStateProperty.all(Size.zero),
                                padding: MaterialStateProperty.all(
                                    const EdgeInsets.all(3)),
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                              onPressed: () {},
                            ),
                            horizontalSpaceSmall,
                            TextButton(
                              child: const Text('Send Invite'),
                              style: ButtonStyle(
                                minimumSize:
                                    MaterialStateProperty.all(Size.zero),
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                padding:
                                    MaterialStateProperty.all(EdgeInsets.zero),
                              ),
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: horizontalAppPadding),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      const Text(
                        'Your Favorites',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      CustomButton(text: 'Show All', onPressed: () {})
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Container(
                  height: 200.0,
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(
                        horizontal: horizontalAppPadding - 4),
                    shrinkWrap: true,
                    itemExtent:
                        screenWidth(context) / 2 - (horizontalAppPadding - 4),
                    scrollDirection: Axis.horizontal,
                    itemCount: state.profile.favourites!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return RestaurantCardSmall(
                        restaurant: state.profile.favourites![index],
                      );
                    },
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    verticalSpaceMedium,
                    const Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: horizontalAppPadding),
                      child: Text(
                        'Quick Links',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    verticalSpaceSmall,
                    Column(
                      children: ListTile.divideTiles(
                          context: context,
                          tiles: <ListTile>[
                            ListTile(
                              dense: true,
                              visualDensity: VisualDensity.compact,
                              leading: const Icon(Icons.settings),
                              title: const Text('Settings'),
                              trailing: const Icon(Icons.keyboard_arrow_right),
                              onTap: () {},
                            ),
                            ListTile(
                              dense: true,
                              visualDensity: VisualDensity.compact,
                              leading: const Icon(Icons.contact_support),
                              title: const Text('Customer Support'),
                              trailing: const Icon(Icons.keyboard_arrow_right),
                              onTap: () {},
                            ),
                            ListTile(
                              dense: true,
                              visualDensity: VisualDensity.compact,
                              leading: const Icon(Icons.bug_report),
                              title: const Text('Report a Bug'),
                              trailing: const Icon(Icons.keyboard_arrow_right),
                              onTap: () {},
                            ),
                            ListTile(
                              dense: true,
                              visualDensity: VisualDensity.compact,
                              leading: const Icon(Icons.logout),
                              title: const Text('Logout'),
                              onTap: () {
                                context
                                    .read<AuthenticationBloc>()
                                    .add(AuthenticationLogoutRequested());
                              },
                            ),
                          ]).toList(),
                    ),
                  ],
                ),
              ),
              SliverToBoxAdapter(
                child: SizedBox.fromSize(
                  size: const Size.fromHeight(80),
                ),
              )
            ],
          );
        }

        return Container();
      },
    );
  }
}
