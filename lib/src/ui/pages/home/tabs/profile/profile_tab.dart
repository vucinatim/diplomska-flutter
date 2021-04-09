import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_menu_flutter/src/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:web_menu_flutter/src/ui/pages/home/tabs/profile/profile_page.dart';
import 'package:web_menu_flutter/src/ui/pages/login/welcome_page.dart';

class ProfileTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (BuildContext context, AuthenticationState state) {
        switch (state.status) {
          case AuthenticationStatus.unauthenticated:
            return WelcomePage();
          case AuthenticationStatus.authenticated:
            return ProfilePage();
          case AuthenticationStatus.unknown:
            return const Center(child: Text('Something went wrong'));
        }
      },
    );
  }
}
