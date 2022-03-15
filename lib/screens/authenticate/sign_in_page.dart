import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shopping_list/services/authentication_service.dart';
import 'package:flutter_shopping_list/screens/authenticate/sign_up_page.dart';
import 'package:provider/provider.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  dynamic firebaseResponse = "";
  bool _isObscure = true;
  final _formKey = GlobalKey<FormState>();
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
            child: Form(
                key: _formKey,
                child: ListView(
                    // shrinkWrap: true,
                    padding: const EdgeInsets.all(10),
                    children: [
                      const SizedBox(height: 50),
                      TextFormField(
                          validator: (val) {
                            if (val == null ||
                                val.isEmpty ||
                                !(RegExp(
                                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                    .hasMatch(val))) {
                              return 'Please enter a valid email address.';
                            }
                            return null;
                          },
                          controller: emailController,
                          decoration: InputDecoration(
                              labelText: "Email",
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.green.shade200,
                                      width: 2.0)))),
                      const SizedBox(height: 10),
                      TextFormField(
                          validator: (val) {
                            if (val == null || val.isEmpty) {
                              return 'Please enter some text.';
                            }
                            if (val.length < 6) return 'Password too short';
                            return null;
                          },
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
                                      color: Colors.green.shade200,
                                      width: 2.0)))),
                      const SizedBox(height: 25),
                      Center(
                          child: Text(firebaseResponse.toString(),
                              style: const TextStyle(color: Colors.red),
                              textAlign: TextAlign.center)),
                      const SizedBox(height: 25),
                      Container(
                          margin: const EdgeInsets.only(left: 115, right: 115),
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  minimumSize: const Size(1, 50),
                                  primary: Colors.green.shade200),
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  firebaseResponse = await context
                                      .read<AuthenticationService>()
                                      .signIn(emailController.text.trim(),
                                          passwordController.text.trim());
                                } else {
                                  firebaseResponse = "";
                                }
                                setState(() {});
                              },
                              child: const Text("Sign in"))),
                      const SizedBox(height: 35),
                      const SizedBox(height: 35),
                      Center(
                          child: IntrinsicWidth(
                              child: Row(
                        children: [
                          const Text("Don't have an account yet?"),
                          const SizedBox(width: 10),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.green.shade200),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const SignUpPage()));
                              },
                              child: const Text("Sign up here"))
                        ],
                      ))),
                    ]))));
  }
}
