import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shopping_list/services/database_service.dart';
import 'package:provider/provider.dart';
import '../../models/user.dart';

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
            appBar: AppBar(backgroundColor: Colors.green.shade200),
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
                            return _buildListItem(
                                context,
                                snapshot.data.docs[index],
                                uid,
                                houseId.toString());
                          },
                        );
                      });
                }));
  }
}

Widget _buildListItem(
    BuildContext context, DocumentSnapshot doc, String userId, String houseId) {
  return ListTile(
    onTap: () {},
    title: Row(
      children: [
        Expanded(child: Text('${doc['name']}')),
        const SizedBox(
          height: 5,
        ),
      ],
    ),
  );
}
