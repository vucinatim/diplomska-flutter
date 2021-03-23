part of 'theme_bloc.dart';

@immutable
abstract class ThemeEvent extends Equatable {
  const ThemeEvent();
}

class LoadTheme extends ThemeEvent {
  @override
  List<Object> get props => <Object>[];
}

class ChangeTheme extends ThemeEvent {
  const ChangeTheme({
    required this.theme,
  });

  final String theme;

  @override
  List<Object> get props => <Object>[theme];
}
