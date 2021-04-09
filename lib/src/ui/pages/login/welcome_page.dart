import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:web_menu_flutter/src/app/routing/router.dart';
import 'package:web_menu_flutter/src/ui/pages/login/login_page.dart';
import 'package:web_menu_flutter/src/ui/pages/login/widgets/rounded_button.dart';

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
            top: 0,
            left: 0,
            child: Image.asset(
              'assets/images/main_top.png',
              width: size.width * 0.3,
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: Image.asset(
              'assets/images/main_bottom.png',
              width: size.width * 0.16,
            ),
          ),
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'WELCOME TO WEB MENU',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: size.height * 0.05),
                SvgPicture.asset(
                  'assets/icons/chat.svg',
                  height: size.height * 0.45,
                ),
                SizedBox(height: size.height * 0.05),
                Hero(
                  tag: 'loginButton',
                  child: RoundedButton(
                    text: 'LOGIN',
                    color: Theme.of(context).primaryColor,
                    onPressed: () {
                      Navigator.of(context).pushNamed(AppRouter.LoginRoute);
                    },
                  ),
                ),
                Hero(
                  tag: 'signUpButton',
                  child: RoundedButton(
                    text: 'SIGN UP',
                    color: Theme.of(context).colorScheme.secondary,
                    textColor: Colors.black,
                    onPressed: () {
                      Navigator.of(context).pushNamed(AppRouter.SignUpRoute);
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
