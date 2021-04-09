import 'package:equatable/equatable.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_menu_flutter/src/app.dart';
import 'package:web_menu_flutter/src/blocs/simple_bloc_observer.dart';
import 'package:web_menu_flutter/src/repositories/profile_repository.dart';

import 'package:web_menu_flutter/src/repositories/repositories.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = SimpleBlocObserver();
  await Firebase.initializeApp();
  EquatableConfig.stringify = kDebugMode;
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
