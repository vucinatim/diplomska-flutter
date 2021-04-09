import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:web_menu_flutter/src/app/routing/router.dart';
import 'package:web_menu_flutter/src/ui/pages/login/widgets/already_have_an_account_check.dart';
import 'package:web_menu_flutter/src/ui/pages/login/widgets/rounded_button.dart';
import 'package:web_menu_flutter/src/ui/pages/login/widgets/rounded_input_field.dart';
import 'package:web_menu_flutter/src/ui/pages/login/widgets/rounded_password_field.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        top: false,
        child: Container(
          width: double.infinity,
          height: size.height,
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Positioned(
                top: 0,
                left: 0,
                child: Image.asset(
                  'assets/images/main_top.png',
                  width: size.width * 0.35,
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Image.asset(
                  'assets/images/login_bottom.png',
                  width: size.width * 0.4,
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).padding.top,
                left: 10,
                child: IconButton(
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
              SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text(
                      'LOGIN',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: size.height * 0.03),
                    SvgPicture.asset(
                      'assets/icons/login.svg',
                      height: size.height * 0.35,
                    ),
                    SizedBox(height: size.height * 0.03),
                    RoundedInputField(
                      hintText: 'Your Email',
                      onChanged: (String value) {},
                    ),
                    RoundedPasswordField(
                      onChanged: (String value) {},
                    ),
                    Hero(
                      tag: 'loginButton',
                      child: RoundedButton(
                        text: 'LOGIN',
                        color: Theme.of(context).primaryColor,
                        onPressed: () {
                          print('Do the login');
                        },
                      ),
                    ),
                    SizedBox(height: size.height * 0.03),
                    AlreadyHaveAnAccountCheck(
                      onPressed: () {
                        Navigator.of(context)
                            .pushReplacementNamed(AppRouter.SignUpRoute);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
