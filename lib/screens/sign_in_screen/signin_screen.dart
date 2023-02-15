import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gram/providers/signin_provider.dart';
import 'package:flutter_gram/resources/auth_methods.dart';
import 'package:flutter_gram/screens/home_screen/home_screen.dart';
import 'package:flutter_gram/screens/sign_in_screen/widgets/custom_textfield.dart';
import 'package:flutter_gram/screens/sign_in_screen/widgets/google_signin.dart';
import 'package:flutter_gram/screens/sign_in_screen/widgets/or_widget.dart';
import 'package:flutter_gram/screens/sign_in_screen/widgets/password_textfield.dart';
import 'package:flutter_gram/screens/sign_in_screen/widgets/signing_bottom_text.dart';
import 'package:flutter_gram/screens/sign_in_screen/widgets/signing_titles.dart';
import 'package:flutter_gram/screens/signup_screen/signup_screen.dart';
import 'package:flutter_gram/utils/colors.dart';
import 'package:flutter_gram/utils/constants.dart';
import 'package:flutter_gram/utils/strings.dart';
import 'package:provider/provider.dart';

class SigninScreen extends StatelessWidget {
  SigninScreen({Key? key}) : super(key: key);
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0.0,
      ),
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 30),
          child: Form(
            key: _formKey,
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
                  validator: validateEmail,
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
                SizedBox(
                  width: size.width * 0.8,
                  height: 50,
                  child: Consumer<SigninProvider>(
                    builder: (context, provider, child) => ElevatedButton(
                        onPressed: () {
                          signinUser(context);
                        },
                        child: provider.isLoading
                            ? const CircularProgressIndicator(
                                color: signinloadingcolor,
                              )
                            : const Text('Sign In')),
                  ),
                ),
                kHeight10,
                OrWidget(size: size),
                kHeight10,
                GoogleSignin(
                  size: size,
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
      ),
    );
  }

  signinUser(BuildContext context) async {
    final provider = Provider.of<SigninProvider>(context, listen: false);
    if (_formKey.currentState!.validate()) {
      provider.changeisLoading = true;
      String res = await AuthMethods().loginUser(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim());
      if (res == 'success') {
        provider.changeisLoading = false;
        // ignore: use_build_context_synchronously
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const HomeScreen()));
      } else {
        provider.changeisLoading = false;
        // ignore: use_build_context_synchronously
        AnimatedSnackBar.material('Invalid Credentials',
                type: AnimatedSnackBarType.error,
                duration: const Duration(seconds: 4))
            .show(context);
        print(res);
      }
    }
  }

  navigateToSignup(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => SignupScreen(),
    ));
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
