import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:web_menu_flutter/src/app/routing/router.dart';
import 'package:web_menu_flutter/src/ui/pages/login/widgets/already_have_an_account_check.dart';
import 'package:web_menu_flutter/src/ui/pages/login/widgets/or_divider.dart';
import 'package:web_menu_flutter/src/ui/pages/login/widgets/rounded_button.dart';
import 'package:web_menu_flutter/src/ui/pages/login/widgets/rounded_input_field.dart';
import 'package:web_menu_flutter/src/ui/pages/login/widgets/rounded_password_field.dart';
import 'package:web_menu_flutter/src/ui/pages/login/widgets/social_icon_button.dart';

class SignUpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        top: false,
        child: Container(
          height: size.height,
          width: double.infinity,
          // Here i can use size.width but use double.infinity because both work as a same
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Positioned(
                top: 0,
                left: 0,
                child: Image.asset(
                  'assets/images/signup_top.png',
                  width: size.width * 0.35,
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                child: Image.asset(
                  'assets/images/main_bottom.png',
                  width: size.width * 0.20,
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
                      'SIGNUP',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: size.height * 0.02),
                    SvgPicture.asset(
                      'assets/icons/signup.svg',
                      height: size.height * 0.30,
                    ),
                    SizedBox(height: size.height * 0.01),
                    RoundedInputField(
                      hintText: 'Your Email',
                      onChanged: (String value) {},
                    ),
                    RoundedPasswordField(
                      onChanged: (String value) {},
                    ),
                    Hero(
                      tag: 'signUpButton',
                      child: RoundedButton(
                        text: 'SIGNUP',
                        color: Theme.of(context).primaryColor,
                        onPressed: () {},
                      ),
                    ),
                    SizedBox(height: size.height * 0.03),
                    AlreadyHaveAnAccountCheck(
                      login: false,
                      onPressed: () {
                        Navigator.of(context)
                            .pushReplacementNamed(AppRouter.LoginRoute);
                      },
                    ),
                    OrDivider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SocialIconButton(
                          icon: FontAwesomeIcons.facebookF,
                          onPressed: () {},
                        ),
                        SocialIconButton(
                          icon: FontAwesomeIcons.twitter,
                          onPressed: () {},
                        ),
                        SocialIconButton(
                          icon: FontAwesomeIcons.google,
                          onPressed: () {},
                        ),
                      ],
                    )
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
