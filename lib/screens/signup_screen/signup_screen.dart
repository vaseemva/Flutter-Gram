import 'package:flutter/material.dart';
import 'package:flutter_gram/screens/sign_in_screen/widgets/custom_textfield.dart';
import 'package:flutter_gram/screens/sign_in_screen/widgets/google_signin.dart';
import 'package:flutter_gram/screens/sign_in_screen/widgets/or_widget.dart';
import 'package:flutter_gram/screens/sign_in_screen/widgets/password_textfield.dart';
import 'package:flutter_gram/screens/sign_in_screen/widgets/signing_titles.dart';
import 'package:flutter_gram/screens/signup_screen/widgets/signup_bottom_text.dart';
import 'package:flutter_gram/screens/signup_screen/widgets/signup_button.dart';
import 'package:flutter_gram/utils/constants.dart';
import 'package:flutter_gram/utils/strings.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({Key? key}) : super(key: key);
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.only(left: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SigningTitles(title: 'Let’s Get Started', subtitle: signUpSubtitle),
            SizedBox(
              height: size.height * 0.0500,
            ),
            const Text('Full Name'),
            kHeight10,
            CustomTextField(
              size: size,
              controller: _nameController,
              inputType: TextInputType.name,
              labelText: 'Name',
            ),
            kHeight10,
            const Text('Email Address'),
            kHeight10,
            CustomTextField(
                size: size,
                controller: _emailController,
                inputType: TextInputType.emailAddress,
                labelText: 'Email Address'),
            kHeight10,
            const Text('Password'),
            kHeight10,
            PasswordTextField(
                size: size,
                passwordController: _passwordController,
                inputType: TextInputType.visiblePassword),
            kHeight10,
            const Text('Confirm Password'),
            kHeight10,
            CustomTextField(
              size: size,
              controller: _confirmPasswordController,
              inputType: TextInputType.visiblePassword,
              labelText: "Confirm Password",
              obscure: true,
            ),
            kHeight20,
            SignupButton(
              size: size,
            ),
            kHeight10,
            OrWidget(size: size),
            kHeight10,
            GoogleSignin(size: size, onPressed: () {}),
            kHeight20,
           SignUpBottomText(longText: 'Already have an account?', buttonText: 'Sign In')
          ],
        ),
      ),
    );
  }
}
