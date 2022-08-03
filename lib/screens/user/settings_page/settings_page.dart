import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shopping_list/services/database_service.dart';
import 'package:flutter_shopping_list/shared/custom_show_dialog_with_fields.dart';
import 'package:provider/provider.dart';
import '../../../models/user.dart';

import 'package:flutter_shopping_list/shared/loading.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    final String uid = Provider.of<SimpleUser?>(context)!.uid;
    return loading
        ? const Loading()
        : Scaffold(
            appBar: AppBar(title: const Center(child: Text('Członkowie domu'))),
            body: FutureBuilder(
                future: DatabaseService.getHouseId(uid),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) return const Loading();
                  Object? houseId = snapshot.data;

                  return StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('users')
                          .where('houseId', isEqualTo: houseId)
                          .snapshots(),
                      builder: (context, AsyncSnapshot snapshot) {
                        if (!snapshot.hasData) return const Loading();
                        return ListView.builder(
                          itemExtent: 80,
                          itemCount: snapshot.data.docs.length,
                          itemBuilder: (context, index) {
                            return Container(
                                margin: const EdgeInsets.only(
                                    left: 10, right: 10, bottom: 10),
                                child: _buildListItem(
                                    context,
                                    snapshot.data.docs[index],
                                    uid,
                                    houseId.toString()));
                          },
                        );
                      });
                }));
  }
}

Widget _buildListItem(
    BuildContext context, DocumentSnapshot doc, String userId, String houseId) {
  // jesli dokument jest aktualnego uzytkownika
  if (doc['userId'] == userId) {
    return ListTile(
      onTap: () {},
      title: Row(
        children: [
          Expanded(child: Text('${doc['name']} (Ty)')),
          IconButton(
            onPressed: () {
              customShowDialogWithFields(
                  context,
                  'Jak chcesz się nazywać?',
                  'Nowa nazwa',
                  20,
                  DatabaseService.changeNameOfUser,
                  userId,
                  '');
            },
            icon: const Icon(Icons.edit),
          ),
        ],
      ),
    );
  } else {
    return ListTile(
      onTap: () {},
      title: Row(
        children: [
          Expanded(child: Text('${doc['name']}')),
        ],
      ),
    );
  }
}
