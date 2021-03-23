import 'package:flutter/material.dart';
import 'package:web_menu_flutter/src/ui/pages/home/tabs/restaurants/restaurants_tab.dart';
import 'package:web_menu_flutter/src/ui/utils/shapes.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  static const double _fabWidth = 60;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        bottomNavigationBar: BottomAppBar(
          child: TabBar(
            labelColor: Theme.of(context).primaryColor,
            unselectedLabelColor:
                Theme.of(context).iconTheme.color!.withOpacity(0.6),
            labelStyle:
                const TextStyle(fontSize: 10.0, fontWeight: FontWeight.w600),
            tabs: <Widget>[
              Container(
                height: 50,
                padding: const EdgeInsets.only(right: _fabWidth / 2),
                child: const Tab(
                  icon: Icon(Icons.restaurant_menu),
                  iconMargin: EdgeInsets.only(bottom: 1),
                  text: 'Restaurants',
                ),
              ),
              Container(
                height: 50,
                padding: const EdgeInsets.only(left: _fabWidth / 2),
                child: const Tab(
                  icon: Icon(Icons.person),
                  iconMargin: EdgeInsets.only(bottom: 1),
                  text: 'Profile',
                ),
              ),
            ],
          ),
          notchMargin: 8.0,
          shape: ConvexCircularNotch(),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: MediaQuery.of(context).viewInsets.bottom == 0.0
            ? Padding(
                padding: EdgeInsets.only(top: 20),
                child: SizedBox(
                  width: _fabWidth,
                  child: FloatingActionButton(
                    onPressed: () {},
                    child: Icon(Icons.qr_code),
                  ),
                ),
              )
            : null,
        body: TabBarView(
          children: <Widget>[
            RestaurantsTab(),
            // const Center(child: Text('QR SCANNER')),
            const Center(child: Text('PROFILE')),
          ],
        ),
      ),
    );
  }
}
