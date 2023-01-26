import 'package:flutter/material.dart';
import 'package:flutter_gram/screens/sign_in_screen/widgets/custom_textfield.dart';
import 'package:flutter_gram/screens/sign_in_screen/widgets/google_signin.dart';
import 'package:flutter_gram/screens/sign_in_screen/widgets/or_widget.dart';
import 'package:flutter_gram/screens/sign_in_screen/widgets/password_textfield.dart';
import 'package:flutter_gram/screens/sign_in_screen/widgets/signing_bottom_text.dart';
import 'package:flutter_gram/screens/sign_in_screen/widgets/signing_button.dart';
import 'package:flutter_gram/screens/sign_in_screen/widgets/signing_titles.dart';
import 'package:flutter_gram/screens/signup_screen/signup_screen.dart';
import 'package:flutter_gram/utils/constants.dart';
import 'package:flutter_gram/utils/strings.dart';

class SigninScreen extends StatelessWidget {
  SigninScreen({Key? key}) : super(key: key);
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SigningTitles(
                title: 'Sign In',
                subtitle: signInSubtitle,
              ),
              SizedBox(
                height: size.height * 0.0500,
              ),
              const Text('Email Address'),
              kHeight10,
              CustomTextField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                size: size,
                controller: _emailController,
                inputType: TextInputType.emailAddress,
                labelText: 'Email',
              ),
              kHeight10,
              const Text('Password'),
              kHeight10,
              PasswordTextField(
                size: size,
                passwordController: _passwordController,
                inputType: TextInputType.visiblePassword,
              ),
              kHeight20,
              SigningButton(
                size: size,
                buttonText: 'Sign In',
                onPressed: () {},
              ),
              kHeight10,
              OrWidget(size: size),
              kHeight10,
              GoogleSignin(
                size: size,
                onPressed: () {},
              ),
              kHeight20,
              const SigningBottomText(
                longText: "Don't have an account?",
                buttonText: 'Create One',
              )
            ],
          ),
        ),
      ),
    );
  }

  navigateToSignup(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => SignupScreen(),
    ));
  }
}
