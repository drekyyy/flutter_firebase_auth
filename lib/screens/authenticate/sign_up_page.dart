import 'package:flutter/material.dart';
import 'package:flutter_shopping_list/services/authentication_service.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  dynamic firebaseResponse = "";

  bool _isObscure = true;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController1 = TextEditingController();
  final TextEditingController passwordController2 = TextEditingController();
  String password1 = "";
  String password2 = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Center(child: Text('Shopping list')),
          backgroundColor: Colors.green.shade200,
        ),
        body: Center(
            child: Column(children: [
          Flexible(fit: FlexFit.tight, flex: 1, child: Container(height: 10)),
          Flexible(
              flex: 6,
              child: Container(
                  margin: const EdgeInsets.only(left: 10, right: 10),
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: Form(
                      key: _formKey,
                      child: ListView(
                          padding: const EdgeInsets.all(10),
                          children: [
                            const Center(
                                child: Text("Rejestracja",
                                    style: TextStyle(fontSize: 25))),
                            const SizedBox(height: 20),
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
                                decoration: const InputDecoration(
                                  labelText: "Email",
                                )),
                            const SizedBox(height: 10),
                            TextFormField(
                                validator: (val) {
                                  if (val == null || val.isEmpty) {
                                    return 'Please enter some text.';
                                  }
                                  if (val.length < 6)
                                    return 'Password too short';
                                  if (password1 != password2) {
                                    return 'Passwords do not match';
                                  }
                                  return null;
                                },
                                onChanged: (val) {
                                  setState(() => password1 = val);
                                },
                                obscureText: _isObscure,
                                controller: passwordController1,
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
                                )),
                            const SizedBox(height: 10),
                            TextFormField(
                                validator: (val) {
                                  if (val == null || val.isEmpty) {
                                    return 'Please enter some text.';
                                  }
                                  if (val.length < 6)
                                    return 'Password too short';
                                  if (password1 != password2) {
                                    return 'Passwords do not match';
                                  }
                                  return null;
                                },
                                onChanged: (val) {
                                  setState(() => password2 = val);
                                },
                                obscureText: _isObscure,
                                controller: passwordController2,
                                decoration: InputDecoration(
                                  labelText: "Confirm Password",
                                  suffixIcon: IconButton(
                                      icon: Icon(_isObscure
                                          ? Icons.visibility
                                          : Icons.visibility_off),
                                      onPressed: () {
                                        setState(() {
                                          _isObscure = !_isObscure;
                                        });
                                      }),
                                )),
                            Center(
                                child: Text(firebaseResponse.toString(),
                                    style: const TextStyle(color: Colors.red),
                                    textAlign: TextAlign.center)),
                            const SizedBox(height: 10),
                            Container(
                                margin: const EdgeInsets.only(
                                    left: 115, right: 115),
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      minimumSize: const Size(1, 50),
                                      //primary: Colors.green.shade200,
                                    ),
                                    onPressed: () async {
                                      if (_formKey.currentState!.validate()) {
                                        firebaseResponse = await context
                                            .read<AuthenticationService>()
                                            .signUp(
                                                emailController.text.trim(),
                                                passwordController1.text
                                                    .trim());
                                        Navigator.pop(context);
                                      } else {
                                        firebaseResponse = "";
                                      }
                                      setState(() {});
                                    },
                                    child: const Text("Sign up"))),
                            const SizedBox(height: 25),
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
                          ])))),
          Flexible(flex: 1, child: Container(height: 10)),
        ])));
  }
}
