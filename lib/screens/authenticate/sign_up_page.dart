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
        appBar: AppBar(title: const Text('Utwórz konto')),
        body: Center(
            child: Column(children: [
          Flexible(
              flex: 14,
              child: Container(
                  margin: const EdgeInsets.only(left: 10, right: 10),
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: Form(
                      key: _formKey,
                      child: ListView(
                          padding: const EdgeInsets.all(10),
                          children: [
                            const SizedBox(height: 20),
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
                                  if (password1 != password2) {
                                    return 'Hasła się nie zgadzają.';
                                  }
                                  return null;
                                },
                                onChanged: (val) {
                                  setState(() => password1 = val);
                                },
                                obscureText: _isObscure,
                                controller: passwordController1,
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
                            TextFormField(
                                validator: (val) {
                                  if (val == null || val.isEmpty) {
                                    return 'Proszę podać hasło.';
                                  }
                                  if (val.length < 6) {
                                    return 'Hasło za krótkie.';
                                  }
                                  if (password1 != password2) {
                                    return 'Hasła się nie zgadzają.';
                                  }
                                  return null;
                                },
                                onChanged: (val) {
                                  setState(() => password2 = val);
                                },
                                obscureText: _isObscure,
                                controller: passwordController2,
                                decoration: InputDecoration(
                                  labelText: "Potwierdź hasło",
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
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  minimumSize: const Size(300, 45),
                                ),
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    firebaseResponse = await context
                                        .read<AuthenticationService>()
                                        .signUp(emailController.text.trim(),
                                            passwordController1.text.trim());
                                    Navigator.pop(context);
                                  } else {
                                    firebaseResponse = "";
                                    setState(() {});
                                  }
                                },
                                child: const Text("Zarejestruj")),
                          ])))),
          Flexible(flex: 1, child: Container(height: 10)),
        ])));
  }
}
