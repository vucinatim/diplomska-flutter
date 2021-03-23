import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_menu_flutter/src/app.dart';
import 'package:web_menu_flutter/src/blocs/simple_bloc_observer.dart';

import 'package:web_menu_flutter/src/repositories/repositories.dart';

void main() {
  Bloc.observer = SimpleBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(App(
    authenticationRepository: AuthenticationRepository(),
    restaurantRepository: RestaurantRepository(),
  ));
}
