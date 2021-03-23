import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_menu_flutter/src/blocs/restaurants_bloc/restaurants_bloc.dart';
import 'package:web_menu_flutter/src/repositories/repositories.dart';
import 'package:web_menu_flutter/src/repositories/restaurant_repository.dart';

import 'app/routing/router.dart';
import 'blocs/restaurant_bloc/restaurant_bloc.dart';
import 'blocs/theme_bloc/theme_bloc.dart';

class App extends StatelessWidget {
  const App({
    Key? key,
    required this.authenticationRepository,
    required this.restaurantRepository,
  })   : assert(authenticationRepository != null),
        assert(restaurantRepository != null),
        super(key: key);

  final AuthenticationRepository authenticationRepository;
  final RestaurantRepository restaurantRepository;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: <RepositoryProvider<dynamic>>[
        RepositoryProvider<AuthenticationRepository>(
          create: (BuildContext context) => authenticationRepository,
        ),
      ],
      child: MultiBlocProvider(
        providers: <BlocProvider<dynamic>>[
          // BlocProvider<AuthenticationBloc>(
          //   create: (_) => AuthenticationBloc(
          //     authenticationRepository: authenticationRepository,
          //   ),
          // ),
          BlocProvider<RestaurantsBloc>(
            create: (_) {
              return RestaurantsBloc(
                restaurantRepository: restaurantRepository,
              )..add(LoadRestaurants());
            },
          ),
          BlocProvider<RestaurantBloc>(
            create: (_) {
              return RestaurantBloc(
                restaurantRepository: restaurantRepository,
              );
            },
          ),
          BlocProvider<ThemeBloc>(
            create: (_) => ThemeBloc()..add(LoadTheme()),
          ),
        ],
        child: AppView(),
      ),
    );
  }
}

class AppView extends StatefulWidget {
  @override
  _AppViewState createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (BuildContext context, ThemeState themeState) {
        return MaterialApp(
          title: 'Cico Admin Panel',
          theme: themeState.themeData,

          /// Navigation
          navigatorKey: _navigatorKey,
          onGenerateRoute: AppRouter.generateRoute,
          initialRoute: AppRouter.HomeRoute,

          builder: (BuildContext context, Widget? child) {
            return child!;
          },
        );
      },
    );
  }
}
