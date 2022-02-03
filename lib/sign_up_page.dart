import 'package:flutter/material.dart';
import 'package:flutter_shopping_list/authentication_service.dart';
import 'package:flutter_shopping_list/sign_in_page.dart';
import 'package:provider/src/provider.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool _isObscure = true;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Center(child: Text('Shopping list')),
          backgroundColor: Colors.green.shade200,
        ),
        body: Center(
            child: ListView(
                // shrinkWrap: true,
                padding: const EdgeInsets.all(10),
                children: [
              const SizedBox(height: 50),
              TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                      labelText: "Email",
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.green.shade200, width: 2.0)))),
              const SizedBox(height: 10),
              TextField(
                  obscureText: _isObscure,
                  controller: passwordController,
                  decoration: InputDecoration(
                      labelText: "Password",
                      suffixIcon: IconButton(
                          icon: Icon(_isObscure
                              ? Icons.visibility
                              : Icons.visibility_off),
                          onPressed: () {
                            setState(() {
                              _isObscure = !_isObscure;
                            });
                          }),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.green.shade200, width: 2.0)))),
              const SizedBox(height: 25),
              Container(
                  margin: const EdgeInsets.only(left: 115, right: 115),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          minimumSize: const Size(1, 50),
                          primary: Colors.green.shade200),
                      onPressed: () {
                        context.read<AuthenticationService>().signIn(
                            emailController.text.trim(),
                            passwordController.text.trim());
                      },
                      child: const Text("Sign up"))),
              const SizedBox(height: 35),
              Center(
                  child: IntrinsicWidth(
                      child: Row(
                children: [
                  const Text("Have an account already?"),
                  const SizedBox(width: 10),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Colors.green.shade200),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("Sign in here"))
                ],
              ))),
            ])));
  }
}
