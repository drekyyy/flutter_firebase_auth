import 'package:flutter/material.dart';
import 'package:flutter_shopping_list/authentication_service.dart';
import 'package:flutter_shopping_list/sign_up_page.dart';
import 'package:provider/provider.dart';

class SignInPage extends StatelessWidget {
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
            child: Container(
                margin: const EdgeInsets.all(10),
                child: ListView(children: [
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
                      controller: passwordController,
                      decoration: InputDecoration(
                          labelText: "Password",
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
                          child: const Text("Sign in"))),
                  const SizedBox(height: 25),
                  Row(
                    children: [
                      const Text("Don't have an account yet?"),
                      const SizedBox(width: 5),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Colors.green.shade200),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignUpPage()));
                          },
                          child: const Text("Sign up here"))
                    ],
                  ),
                ]))));
  }
}
