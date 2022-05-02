import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shopping_list/services/authentication_service.dart';
import 'package:provider/src/provider.dart';

import '../models/user.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final AuthenticationService authService =
    //     Provider.of<AuthenticationService>(context);
    final String uid = Provider.of<SimpleUser?>(context)!.uid;
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
          Text('user id: ' + uid),
          const Text("Home"),
        ])));
  }
}
