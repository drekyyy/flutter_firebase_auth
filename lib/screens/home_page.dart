import 'package:flutter/material.dart';
import 'package:flutter_shopping_list/services/authentication_service.dart';
import 'package:provider/src/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Center(child: Text('Ekran główny')),
            backgroundColor: Colors.green.shade200,
            actions: <Widget>[
              ElevatedButton(
                style: ButtonStyle(
                    elevation: null,
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Colors.green.shade200)),
                child: const Text("Wyloguj"),
                onPressed: () {
                  context.read<AuthenticationService>().signOut();
                },
              )
            ]),
        body: Center(
            child: Column(children: [
          const Text("Home"),
        ])));
  }
}
