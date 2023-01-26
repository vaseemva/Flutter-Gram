import 'package:flutter/material.dart';
import 'package:flutter_gram/providers/password_provider.dart';
import 'package:provider/provider.dart';

class PasswordTextField extends StatelessWidget {
  const PasswordTextField({
    Key? key,
    required this.size,
    required TextEditingController passwordController,
    required this.inputType,
  })  : _passwordController = passwordController,
        super(key: key);

  final Size size;
  final TextEditingController _passwordController;
  final TextInputType inputType;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PasswordProvider>(context);
    return SizedBox(
      width: size.width * 0.8,
      // height: 50,
      child: TextFormField(
        validator: (value) {
          if(value!.length<6){
            return 'password must be atleast 6 characters';
          }
          return null;
        },
        controller: _passwordController,
        obscureText: provider.isPasswordVisible,
        keyboardType: inputType,
        decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
            border: const OutlineInputBorder(),
            labelText: 'Password',
            suffixIcon: GestureDetector(
              onTap: () {
                provider.togglePasswordVisibility();
              },
              child: Icon(provider.isPasswordVisible
                  ? Icons.visibility_off
                  : Icons.visibility),
            )),
      ),
    );
  }
}
