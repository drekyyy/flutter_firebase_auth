import 'package:flutter/material.dart';

import '../../settings_page/settings_page.dart';

class HamburgerMenu extends StatelessWidget {
  const HamburgerMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
      children: [
        ListTile(
            leading: Icon(Icons.person),
            title: Text('Członkowie domu'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SettingsPage()));
            }),
      ],
    ));
  }
}
