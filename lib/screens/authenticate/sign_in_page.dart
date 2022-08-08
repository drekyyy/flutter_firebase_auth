import 'package:flutter/material.dart';
import 'package:flutter_shopping_list/services/authentication_service.dart';
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
        appBar: AppBar(title: const Text('Zaloguj się')),
        body: Center(
            child: Column(children: [
          Flexible(fit: FlexFit.tight, flex: 1, child: Container(height: 10)),
          Flexible(
              flex: 9,
              child: Container(
                  margin: const EdgeInsets.only(left: 10, right: 10),
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: Form(
                      key: _formKey,
                      child: ListView(
                          padding: const EdgeInsets.all(10),
                          children: [
                            TextFormField(
                                validator: (val) {
                                  if (val == null ||
                                      val.isEmpty ||
                                      !(RegExp(
                                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                          .hasMatch(val))) {
                                    return 'Proszę podać poprawny e-mail.';
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
                                    return 'Proszę podać hasło.';
                                  }
                                  if (val.length < 6) {
                                    return 'Hasło za krótkie.';
                                  }
                                  return null;
                                },
                                obscureText: _isObscure,
                                controller: passwordController,
                                decoration: InputDecoration(
                                  labelText: "Hasło",
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
                            Center(
                                child: Text(firebaseResponse.toString(),
                                    style: const TextStyle(color: Colors.red),
                                    textAlign: TextAlign.center)),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  minimumSize: const Size(300, 45),
                                ),
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    firebaseResponse = await context
                                        .read<AuthenticationService>()
                                        .signIn(emailController.text.trim(),
                                            passwordController.text.trim());
                                    Navigator.pop(context);
                                  } else {
                                    firebaseResponse = "";
                                    setState(() {});
                                  }
                                },
                                child: const Text("Zaloguj")),
                          ])))),
          Flexible(flex: 1, child: Container(height: 10)),
        ])));
  }
}
