import 'package:flutter/material.dart';
import 'package:flutter_shopping_list/authentication_service.dart';
import 'package:provider/src/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Column(children: [
      Text("Home"),
      ElevatedButton(
          onPressed: () {
            context.read<AuthenticationService>().signOut();
          },
          child: Text("Sign out")),
    ])));
  }
}
