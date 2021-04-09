import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:formz/formz.dart';
import 'package:web_menu_flutter/src/app/routing/router.dart';
import 'package:web_menu_flutter/src/blocs/sign_up_cubit/sign_up_cubit.dart';
import 'package:web_menu_flutter/src/ui/pages/login/widgets/login_widgets.dart';

class SignUpForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return BlocListener<SignUpCubit, SignUpState>(
      listener: (BuildContext context, SignUpState state) {
        if (state.status.isSubmissionFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(content: Text('Sign Up Failure')),
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
              'SIGNUP',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.02),
            SvgPicture.asset(
              'assets/icons/signup.svg',
              height: size.height * 0.30,
            ),
            SizedBox(height: size.height * 0.01),
            _EmailInput(),
            _PasswordInput(),
            _ConfirmPasswordInput(),
            _SignUpButton(),
            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountCheck(
              login: false,
              onPressed: () {
                Navigator.of(context)
                    .pushReplacementNamed(AppRouter.LoginRoute);
              },
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
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (SignUpState previous, SignUpState current) =>
          previous.email != current.email,
      builder: (BuildContext context, SignUpState state) {
        return RoundedEmailField(
          hintText: 'Your Email',
          onChanged: (String email) =>
              context.read<SignUpCubit>().emailChanged(email),
          errorMessage: state.email.invalid ? 'invalid email' : null,
        );
      },
    );
  }
}

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (SignUpState previous, SignUpState current) =>
          previous.password != current.password,
      builder: (BuildContext context, SignUpState state) {
        return RoundedPasswordField(
          hintText: 'Password',
          onChanged: (String password) =>
              context.read<SignUpCubit>().passwordChanged(password),
          errorMessage: state.password.invalid ? 'invalid password' : null,
        );
      },
    );
  }
}

class _ConfirmPasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (SignUpState previous, SignUpState current) =>
          previous.password != current.password ||
          previous.confirmedPassword != current.confirmedPassword,
      builder: (BuildContext context, SignUpState state) {
        return RoundedPasswordField(
          hintText: 'Confirm Password',
          onChanged: (String confirmPassword) => context
              .read<SignUpCubit>()
              .confirmedPasswordChanged(confirmPassword),
          errorMessage:
              state.password.invalid ? 'Passwords do not match' : null,
        );
      },
    );
  }
}

class _SignUpButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (SignUpState previous, SignUpState current) =>
          previous.status != current.status,
      builder: (BuildContext context, SignUpState state) {
        return Hero(
          tag: 'signUpButton',
          child: RoundedButton(
            text: 'SIGN UP',
            color: Theme.of(context).primaryColor,
            isLoading: state.status.isSubmissionInProgress,
            onPressed: state.status.isValidated
                ? () => context.read<SignUpCubit>().signUpFormSubmitted()
                : null,
          ),
        );
      },
    );
  }
}
