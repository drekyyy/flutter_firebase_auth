import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_shopping_list/services/database_service.dart';
import 'package:provider/provider.dart';
import '../../../../models/user.dart';
import '../../change_house_page/change_house_page.dart';
import '../../settings_page/settings_page.dart';

class HamburgerMenu extends StatelessWidget {
  const HamburgerMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //String houseId = '';
    final String uid = Provider.of<SimpleUser?>(context)!.uid;
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
            leading: const Icon(Icons.change_circle),
            title: const Text('Zmień dom'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ChangeHousePage()));
            }),
        ListTile(
            iconColor: Colors.white,
            textColor: Colors.white,
            leading: const Icon(Icons.house),
            title: const Text('ID domu'),
            onTap: () async {
              String houseId = await DatabaseService.getHouseId(uid);
              showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: const Text('ID domu',
                      style:
                          TextStyle(color: Color.fromARGB(255, 165, 214, 167))),
                  content: Text(houseId),
                  actions: <Widget>[
                    Center(
                        child: TextButton(
                      onPressed: () {
                        Clipboard.setData(ClipboardData(text: houseId));
                        Navigator.pop(context);
                      },
                      child: const Text('Kopiuj do schowka',
                          style: TextStyle(
                              color: Color.fromARGB(255, 165, 214, 167))),
                    )),
                  ],
                ),
              );
            }),
      ],
    ));
  }
}
