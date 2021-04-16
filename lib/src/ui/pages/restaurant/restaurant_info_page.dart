import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:web_menu_flutter/src/blocs/restaurant_bloc/restaurant_bloc.dart';

import 'package:web_menu_flutter/src/models/models.dart';
import 'package:web_menu_flutter/src/ui/utils/ui_helpers.dart';
import 'package:web_menu_flutter/src/ui/widgets/custom_app_bar.dart';
import 'package:web_menu_flutter/src/ui/widgets/options_menu.dart';

class RestaurantInfoPage extends StatelessWidget {
  Widget buildHeader(String? title, String? description) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: horizontalAppPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title ?? noValueString,
            style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          verticalSpaceModerate,
          Text(description ?? noValueString),
        ],
      ),
    );
  }

  Widget buildAddress(ContactInfo? contactInfo) {
    LatLng mapCenter = const LatLng(45.521563, -122.677433);
    Set<Marker> markers = <Marker>{};

    final double? locationLat = contactInfo?.location?.lat;
    final double? locationLng = contactInfo?.location?.lng;

    if (locationLng != null && locationLat != null) {
      mapCenter = LatLng(locationLat, locationLng);
      markers = <Marker>{
        Marker(
          markerId: MarkerId(contactInfo?.email ?? '-'),
          position: LatLng(locationLat, locationLng),
        ),
      };
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: horizontalAppPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'Address',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          verticalSpaceSmall,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(contactInfo?.address ?? noValueString),
                  verticalSpaceTiny,
                  Opacity(
                    opacity: 0.6,
                    child:
                        Text('${contactInfo?.postNumber} ${contactInfo?.city}'),
                  )
                ],
              ),
              TextButton(
                onPressed: () {},
                child: const Text('Get directions'),
              ),
            ],
          ),
          verticalSpaceSmall,
          Container(
            height: 250,
            child: GoogleMap(
              zoomControlsEnabled: false,
              initialCameraPosition: CameraPosition(
                target: mapCenter,
                zoom: 15.0,
              ),
              markers: markers,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildOpeningHours(
      BuildContext context, Map<String, OpenHours>? openingHours) {
    // const List<String> weekDays = <String>[
    //   'monday',
    //   'tuesday',
    //   'wednesday',
    //   'thursday',
    //   'friday',
    //   'saturday',
    //   'sunday',
    // ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: horizontalAppPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'Opening Hours',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          verticalSpaceSmall,
          openingHours == null
              ? const Center(
                  child: Text(noValueString),
                )
              : Opacity(
                  opacity: 0.7,
                  child: Align(
                    alignment: Alignment.center,
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(
                        maxWidth: 300,
                      ),
                      child: Column(
                        children: List<Widget>.generate(
                          openingHours.keys.length,
                          (int index) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(openingHours.keys.elementAt(index)),
                                Text(
                                    '${openingHours[openingHours.keys.elementAt(index)]!.toTimeString(context)}'),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
        ],
      ),
    );
  }

  Widget buildContactInfo(BuildContext context, ContactInfo? contactInfo) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: horizontalAppPadding),
          child: Text(
            'Contact Info',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        verticalSpaceSmall,
        Column(
          children: <Widget>[
            ListTile(
              title: const Text('Restaurant Phone'),
              visualDensity: VisualDensity.compact,
              trailing: Text(
                contactInfo?.phone ?? noValueString,
                style: TextStyle(color: Theme.of(context).primaryColor),
              ),
              onTap: () {
                print('OPEN PHONE DIAL');
              },
            ),
            const Divider(height: 1),
            ListTile(
              title: const Text('Web site'),
              visualDensity: VisualDensity.compact,
              trailing: Text(
                'Open web site',
                style: TextStyle(color: Theme.of(context).primaryColor),
              ),
              onTap: () {
                print('OPEN WEB SITE');
              },
            ),
            const Divider(height: 1),
            ListTile(
              title: const Text('Web Menu support'),
              visualDensity: VisualDensity.compact,
              trailing: Text(
                'Chat with us',
                style: TextStyle(color: Theme.of(context).primaryColor),
              ),
              onTap: () {
                print('OPEN CHAT OR EMAIL');
              },
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<RestaurantBloc, RestaurantState>(
        builder: (BuildContext context, RestaurantState state) {
          final Restaurant? restaurant =
              state is RestaurantLoaded ? state.restaurant : null;
          final bool isLoading = state is RestaurantLoading;

          if (isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return CustomScrollView(
            slivers: <Widget>[
              SliverPersistentHeader(
                pinned: true,
                delegate: CustomAppBar(
                  minExtent:
                      MediaQuery.of(context).padding.top + kToolbarHeight,
                  maxExtent:
                      MediaQuery.of(context).padding.top + kToolbarHeight,
                  title: restaurant?.name,
                  trailing: OptionsMenu(
                    buttonBackgroundColor: Colors.black.withOpacity(0.1),
                    options: <MenuOption>[
                      MenuOption(
                        child: const Text('Call restaurant'),
                        onPressed: () {
                          print('Calling restaurant');
                        },
                      ),
                      MenuOption(
                        child: const Text('Visit web page'),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
              ),
              restaurant != null
                  ? SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: horizontalAppPadding),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            buildHeader(
                              restaurant.name,
                              restaurant.description,
                            ),
                            verticalSpace(35),
                            buildAddress(restaurant.contactInfo),
                            verticalSpace(35),
                            buildOpeningHours(context, restaurant.openingHours),
                            verticalSpace(35),
                            buildContactInfo(context, restaurant.contactInfo)
                          ],
                        ),
                      ),
                    )
                  : const SliverFillRemaining(
                      child: Center(
                        child: Text('Couldn\'t load restaurant'),
                      ),
                    ),
            ],
          );
        },
      ),
    );
  }
}
