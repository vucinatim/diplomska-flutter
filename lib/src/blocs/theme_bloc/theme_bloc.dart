import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:web_menu_flutter/src/app/services/prefs_service.dart';
import 'package:web_menu_flutter/src/app/theme/app_themes.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeState(themeData: appThemes['defaultTheme']));

  @override
  Stream<ThemeState> mapEventToState(ThemeEvent event) async* {
    if (event is LoadTheme) {
      yield* _mapLoadThemeToState();
    } else if (event is ChangeTheme) {
      yield* _mapChangeThemeToState(event);
    }
  }

  /// LOAD Theme
  Stream<ThemeState> _mapLoadThemeToState() async* {
    final SharedPreferencesService? sharedPrefService =
        await SharedPreferencesService.instance;
    yield ThemeState(
      themeData: sharedPrefService?.theme != null
          ? appThemes[sharedPrefService!.theme!]
          : appThemes['defaultTheme'],
    );
  }

  /// Change Theme
  Stream<ThemeState> _mapChangeThemeToState(ChangeTheme event) async* {
    final SharedPreferencesService? sharedPrefService =
        await SharedPreferencesService.instance;
    await sharedPrefService?.setTheme(event.theme);
    yield ThemeState(
        themeData: appThemes[event.theme] ?? appThemes['defaultTheme']);
  }
}
