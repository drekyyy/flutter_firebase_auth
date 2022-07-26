import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shopping_list/services/database_service.dart';
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
      // shape: const RoundedRectangleBorder(
      //     borderRadius: BorderRadius.all(Radius.circular(20))),
      tileColor: Colors.white,
      onTap: () {},
      title: Row(
        children: [
          Expanded(child: Text('${doc['name']} (Ty)')),
          IconButton(
              onPressed: () {
                final _formKey = GlobalKey<FormState>();
                final TextEditingController userNameController =
                    TextEditingController();
                String userName;
                String? firebaseResponse = '';
                showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: const Text('Jak chcesz sie nazywać?',
                        style: TextStyle(
                            color: Color.fromARGB(255, 165, 214, 167))),
                    content: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextFormField(
                                validator: (val) {
                                  if (val == null || val.isEmpty) {
                                    return 'Please enter some text.';
                                  }
                                  if (val.length > 20) {
                                    return 'Product name too long';
                                  }

                                  return null;
                                },
                                onChanged: (val) {
                                  userName = val;
                                },
                                controller: userNameController,
                                decoration: const InputDecoration(
                                  labelText: "Nozwa nazwa",
                                )),
                            Center(
                                child: TextButton(
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  firebaseResponse =
                                      await DatabaseService.changeNameOfUser(
                                          userId,
                                          userNameController.text.trim());
                                  Navigator.pop(context);
                                } else {
                                  Text(firebaseResponse.toString());
                                  firebaseResponse = '';
                                }
                              },
                              child: const Text('Ok',
                                  style: TextStyle(
                                      color:
                                          Color.fromARGB(255, 165, 214, 167))),
                            )),
                          ],
                        )),
                  ),
                );
              },
              icon: const Icon(Icons.edit),
              color: const Color.fromARGB(255, 165, 214, 167)),
        ],
      ),
    );
  } else {
    return ListTile(
      // shape: const RoundedRectangleBorder(
      //     borderRadius: BorderRadius.all(Radius.circular(20))),
      tileColor: Colors.white,
      onTap: () {},
      title: Row(
        children: [
          Expanded(child: Text('${doc['name']}')),
        ],
      ),
    );
  }
}
