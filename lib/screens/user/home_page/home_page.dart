import 'package:flutter/material.dart';
import 'package:flutter_shopping_list/screens/user/home_page/components/hamburger_menu.dart';
import 'package:flutter_shopping_list/screens/user/settings_page/settings_page.dart';
import 'package:flutter_shopping_list/services/authentication_service.dart';
import 'package:provider/provider.dart';
import '../../../models/user.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String uid = Provider.of<SimpleUser?>(context)!.uid;

    return Scaffold(
        drawer: HamburgerMenu(),
        appBar: AppBar(
            //elevation: 0,
            //leading: HamburgerMenu()
            // ElevatedButton(
            //   child: const Icon(Icons.person),
            //   onPressed: () {
            //     Navigator.push(
            //         context,
            //         MaterialPageRoute(
            //             builder: (context) => const SettingsPage()));
            //   },
            // )

            actions: <Widget>[
              ElevatedButton(
                child: const Text("Wyloguj"),
                onPressed: () {
                  context.read<AuthenticationService>().signOut();
                },
              )
            ]),
        body: Container(
            child: Center(
                child: Column(children: [
          Text('user id: ' + uid, style: const TextStyle(color: Colors.white)),
          const Text("Home"),
        ]))));
  }
}
