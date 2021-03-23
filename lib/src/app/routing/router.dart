import 'package:flutter/material.dart';
import 'package:web_menu_flutter/src/ui/pages/home/home_page.dart';
import 'package:web_menu_flutter/src/ui/pages/pages.dart';

class RoutingData {
  RoutingData({
    this.route,
    Map<String, String>? queryParameters,
  }) : _queryParameters = queryParameters;
  final String? route;
  final Map<String, String>? _queryParameters;

  String? operator [](String key) => _queryParameters![key];
}

class AppRouter {
  static const String SplashRoute = '/splash';
  static const String LoginRoute = '/login';
  static const String SignUpRoute = '/signup';
  static const String ForgotPasswordRoute = '/password/forgot';
  static const String ResetPasswordRoute = '/password/reset';
  static const String ProfileSettings = 'settings';

  static const String HomeRoute = '/home';
  static const String RestaurantsRoute = '/restaurants';

  static const String RestaurantRoute = '/restaurant';

  static const String RestaurantInfoRoute = '/restaurant/info';
  static const String MenuRoute = '/restaurant/menu';
  static const String MenuItemRoute = '/restaurant/menu/item';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    final RoutingData routingData = getRoutingData(settings.name!);
    switch (routingData.route) {
      case SplashRoute:
        return EnterExitRoute(page: SplashPage(), routeName: settings.name);
      case LoginRoute:
        return EnterExitRoute(page: LoginPage(), routeName: settings.name);
      case HomeRoute:
        return EnterExitRoute(page: HomePage(), routeName: settings.name);
      case RestaurantRoute:
        final RestaurantArguments args =
            settings.arguments as RestaurantArguments;
        return EnterExitRoute(
            page: RestaurantMenuPage(restaurantId: args.restaurantId),
            routeName: settings.name);
      case RestaurantInfoRoute:
        return EnterExitRoute(
          page: RestaurantInfoPage(),
          routeName: settings.name,
        );
      default:
        return EnterExitRoute(page: UnknownPage(), routeName: settings.name);
    }
  }

  static RoutingData getRoutingData(String uri) {
    final Uri uriData = Uri.parse(uri);
    print('queryParameters: ${uriData.queryParameters} path: ${uriData.path}');
    return RoutingData(
      queryParameters: uriData.queryParameters,
      route: uriData.path,
    );
  }
}

class OpenRoute extends PageRouteBuilder {
  OpenRoute({
    required final Widget page,
    required final String? routeName,
  }) : super(
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
          settings: RouteSettings(name: routeName),
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              page,
        );
}

class EnterExitRoute extends PageRouteBuilder {
  final Widget page;
  final String? routeName;
  EnterExitRoute({required this.page, this.routeName})
      : super(
          settings: RouteSettings(name: routeName),
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              page,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) {
            final Cubic curve = Curves.easeInOut;
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(1.0, 0.0),
                end: Offset.zero,
              ).animate(CurvedAnimation(
                parent: animation,
                curve: curve,
              )),
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: Offset.zero,
                  end: const Offset(-1.0, 0.0),
                ).animate(CurvedAnimation(
                  parent: secondaryAnimation,
                  curve: curve,
                )),
                child: FadeTransition(
                  opacity: Tween<double>(
                    begin: 1,
                    end: 0.5,
                  ).animate(
                    CurvedAnimation(
                      parent: secondaryAnimation,
                      curve: curve,
                    ),
                  ),
                  child: child,
                ),
              ),
            );
          },
        );
}
