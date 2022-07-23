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
                  //padding: EdgeInsets.all(10),

                  child: Form(
                      key: _formKey,
                      child: ListView(
                          padding: const EdgeInsets.all(10),
                          children: [
                            const Center(
                                child: Text("Logowanie",
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
                                  if (val.length < 6) {
                                    return 'Password too short';
                                  }
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
                                )),
                            const SizedBox(height: 25),
                            Center(
                                child: Text(firebaseResponse.toString(),
                                    style: const TextStyle(color: Colors.red),
                                    textAlign: TextAlign.center)),
                            const SizedBox(height: 25),
                            Container(
                                margin: const EdgeInsets.only(
                                    left: 115, right: 115),
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      minimumSize: const Size(1, 50),
                                    ),
                                    onPressed: () async {
                                      if (_formKey.currentState!.validate()) {
                                        firebaseResponse = await context
                                            .read<AuthenticationService>()
                                            .signIn(emailController.text.trim(),
                                                passwordController.text.trim());
                                      } else {
                                        firebaseResponse = "";
                                        setState(() {});
                                      }
                                    },
                                    child: const Text("Sign in"))),
                            const SizedBox(height: 35),
                            Center(
                                child: IntrinsicWidth(
                                    child: Row(
                              children: [
                                const Text("Don't have an account yet?"),
                                const SizedBox(width: 10),
                                ElevatedButton(
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
                          ])))),
          Flexible(flex: 1, child: Container(height: 10)),
        ])));
  }
}
