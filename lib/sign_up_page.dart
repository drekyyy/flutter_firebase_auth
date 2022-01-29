import 'package:flutter/material.dart';
import 'package:flutter_shopping_list/authentication_service.dart';
import 'package:provider/src/provider.dart';

class SignUpPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        TextField(
            controller: emailController,
            decoration: InputDecoration(labelText: "Email")),
        TextField(
            controller: passwordController,
            decoration: InputDecoration(labelText: "Password")),
        ElevatedButton(
            onPressed: () {
              context.read<AuthenticationService>().signUp(
                  emailController.text.trim(), passwordController.text.trim());
            },
            child: Text("Sign up"))
      ],
    ));
  }
}
