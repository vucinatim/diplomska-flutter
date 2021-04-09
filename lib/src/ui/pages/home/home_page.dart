import 'package:flutter/material.dart';
import 'package:web_menu_flutter/src/app/routing/router.dart';
import 'package:web_menu_flutter/src/ui/pages/home/tabs/profile/profile_tab.dart';
import 'file:///C:/Users/timvu/AndroidStudioProjects/web_menu_flutter/lib/src/ui/pages/login/welcome_page.dart';
import 'package:web_menu_flutter/src/ui/pages/home/tabs/restaurants/restaurants_tab.dart';
import 'package:web_menu_flutter/src/ui/pages/login/welcome_page.dart';
import 'package:web_menu_flutter/src/ui/utils/custom_fab_animator.dart';
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
        floatingActionButtonAnimator: const CustomFabAnimator(),
        bottomNavigationBar: BottomAppBar(
          child: Theme(
            data: ThemeData(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
            ),
            child: TabBar(
              overlayColor: MaterialStateProperty.all(Colors.transparent),
              labelColor: Theme.of(context).primaryColor,
              indicator: const BoxDecoration(),
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
          ),
          notchMargin: 8.0,
          shape: ConvexCircularNotch(),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: MediaQuery.of(context).viewInsets.bottom == 0.0
            ? Padding(
                padding: const EdgeInsets.only(top: 20),
                child: SizedBox(
                  width: _fabWidth,
                  child: FloatingActionButton(
                    elevation: 5,
                    heroTag: null,
                    onPressed: () {
                      Navigator.of(context).pushNamed(AppRouter.ScannerRoute);
                    },
                    child: Container(
                      width: 60,
                      height: 60,
                      child: const Icon(
                        Icons.qr_code,
                        size: 28,
                      ),
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
                    ),
                  ),
                ),
              )
            : null,
        body: TabBarView(
          children: <Widget>[
            RestaurantsTab(),
            // const Center(child: Text('QR SCANNER')),
            ProfileTab(),
            //ProfileTab(),
          ],
        ),
      ),
    );
  }
}
