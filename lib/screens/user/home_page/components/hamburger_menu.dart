import 'package:flutter/material.dart';

import '../../change_house_page/change_house_page.dart';
import '../../settings_page/settings_page.dart';

class HamburgerMenu extends StatelessWidget {
  const HamburgerMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
      children: [
        ListTile(
            iconColor: Colors.white,
            textColor: Colors.white,
            leading: const Icon(Icons.person),
            title: const Text('Członkowie domu'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SettingsPage()));
            }),
        ListTile(
            iconColor: Colors.white,
            textColor: Colors.white,
            leading: const Icon(Icons.house),
            title: const Text('Zmień dom'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ChangeHousePage()));
            }),
      ],
    ));
  }
}
