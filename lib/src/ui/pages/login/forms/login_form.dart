import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:formz/formz.dart';
import 'package:web_menu_flutter/src/app/routing/router.dart';
import 'package:web_menu_flutter/src/blocs/login_cubit/login_cubit.dart';
import 'package:web_menu_flutter/src/ui/pages/login/widgets/login_widgets.dart';

class LoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return BlocListener<LoginCubit, LoginState>(
      listener: (BuildContext context, LoginState state) {
        if (state.status.isSubmissionFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                backgroundColor: Colors.white,
                content: Text(
                  'Authentication Failure',
                  style: TextStyle(color: Theme.of(context).primaryColor),
                ),
              ),
            );
        }

        if (state.status.isSubmissionSuccess) {
          Navigator.of(context).pop();
        }
      },
      child: SingleChildScrollView(
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
            _EmailInput(),
            _PasswordInput(),
            _LoginButton(),
            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountCheck(
              onPressed: () {
                Navigator.of(context)
                    .pushReplacementNamed(AppRouter.SignUpRoute);
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
                  onPressed: () => context.read<LoginCubit>().logInWithGoogle(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (LoginState previous, LoginState current) =>
          previous.email != current.email,
      builder: (BuildContext context, LoginState state) {
        return RoundedEmailField(
          hintText: 'Your Email',
          onChanged: (String email) =>
              context.read<LoginCubit>().emailChanged(email),
          errorMessage: state.email.invalid ? 'invalid email' : null,
        );
      },
    );
  }
}

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (LoginState previous, LoginState current) =>
          previous.password != current.password,
      builder: (BuildContext context, LoginState state) {
        return RoundedPasswordField(
          hintText: 'Password',
          onChanged: (String password) =>
              context.read<LoginCubit>().passwordChanged(password),
          errorMessage: state.password.invalid ? 'invalid password' : null,
        );
      },
    );
  }
}

class _LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (LoginState previous, LoginState current) =>
          previous.status != current.status,
      builder: (BuildContext context, LoginState state) {
        return Hero(
          tag: 'loginButton',
          child: RoundedButton(
            text: 'LOGIN',
            color: Theme.of(context).primaryColor,
            isLoading: state.status.isSubmissionInProgress,
            onPressed: state.status.isValidated
                ? () => context.read<LoginCubit>().logInWithCredentials()
                : null,
          ),
        );
      },
    );
  }
}
