import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_menu_flutter/src/app.dart';
import 'package:web_menu_flutter/src/blocs/simple_bloc_observer.dart';
import 'package:web_menu_flutter/src/repositories/profile_repository.dart';

import 'package:web_menu_flutter/src/repositories/repositories.dart';

void main() {
  Bloc.observer = SimpleBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.dark));
  runApp(App(
    authenticationRepository: AuthenticationRepository(),
    profileRepository: ProfileRepository(),
    restaurantRepository: RestaurantRepository(),
  ));
}
