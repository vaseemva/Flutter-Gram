import 'package:flutter/material.dart';
import 'package:flutter_gram/providers/signin_provider.dart';
import 'package:flutter_gram/resources/auth_methods.dart';
import 'package:flutter_gram/screens/sign_in_screen/signin_screen.dart';
import 'package:flutter_gram/screens/sign_in_screen/widgets/custom_textfield.dart';
import 'package:flutter_gram/screens/sign_in_screen/widgets/google_signin.dart';
import 'package:flutter_gram/screens/sign_in_screen/widgets/or_widget.dart';
import 'package:flutter_gram/screens/sign_in_screen/widgets/password_textfield.dart';
import 'package:flutter_gram/screens/sign_in_screen/widgets/signing_titles.dart';
import 'package:flutter_gram/screens/signup_screen/widgets/signup_bottom_text.dart';
import 'package:flutter_gram/utils/colors.dart';
import 'package:flutter_gram/utils/constants.dart';
import 'package:flutter_gram/utils/strings.dart';
import 'package:provider/provider.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({Key? key}) : super(key: key);
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0.0,
      ),
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.only(left: 30),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SigningTitles(
                  title: 'Let’s Get Started', subtitle: signUpSubtitle),
              SizedBox(
                height: size.height * 0.0500,
              ),
              const Text('Full Name'),
              kHeight10,
              CustomTextField(
                validator: validateName,
                size: size,
                controller: _nameController,
                inputType: TextInputType.name,
                labelText: 'Name',
              ),
              kHeight10,
              const Text('Email Address'),
              kHeight10,
              CustomTextField(
                  validator: validateEmail,
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
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Confirm Password is required.';
                  }
                  if (value != _passwordController.text) {
                    return 'Passwords do not match';
                  }
                  return null;
                },
                size: size,
                controller: _confirmPasswordController,
                inputType: TextInputType.visiblePassword,
                labelText: "Confirm Password",
                obscure: true,
              ),
              kHeight20,
              SizedBox(
                width: size.width * 0.8,
                height: 50,
                child: Consumer<SigninProvider>(
                  builder: (context, provider, child) => ElevatedButton(
                      onPressed: () {
                        signupUser(context);
                      },
                      child: provider.isLoading
                          ? const CircularProgressIndicator(
                              color: signinloadingcolor,
                            )
                          : const Text("Sign Up")),
                ),
              ),
              kHeight10,
              OrWidget(size: size),
              kHeight10,
              GoogleSignin(
                size: size,
              ),
              kHeight20,
              const SignUpBottomText(
                  longText: 'Already have an account?', buttonText: 'Sign In')
            ],
          ),
        ),
      ),
    );
  }

  signupUser(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      final provider = Provider.of<SigninProvider>(context, listen: false);
      provider.changeisLoading = true;
      String res = await AuthMethods().signupUser(
          username: _nameController.text.trim(),
          emailAddress: _emailController.text.trim(),
          password: _passwordController.text.trim());

      if (res == 'success') {
        provider.changeisLoading = false;
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Signed up successfully')));
        // ignore: use_build_context_synchronously
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => SigninScreen(),
        ));
      } else {
        provider.changeisLoading = false;
      }
    }
  }

  String? validateName(String? name) {
    if (name == null || name.isEmpty) {
      return 'Name is required.';
    }
    if (name.length < 3) {
      return 'Name must be at least 3 characters long.';
    }
    return null;
  }

  String? validateEmail(String? email) {
    if (email!.isEmpty) {
      return 'Email is required.';
    }
    if (!RegExp(r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+').hasMatch(email)) {
      return 'Invalid email address.';
    }
    return null;
  }
}
