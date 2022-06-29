import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shopping_list/screens/user/home_page/components/hamburger_menu.dart';
import 'package:flutter_shopping_list/screens/user/settings_page/settings_page.dart';
import 'package:flutter_shopping_list/services/authentication_service.dart';
import 'package:provider/provider.dart';
import '../../../models/user.dart';
import '../../../services/database_service.dart';
import '../../../shared/loading.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final String uid = Provider.of<SimpleUser?>(context)!.uid;

    return Scaffold(
        drawer: const HamburgerMenu(),
        appBar: AppBar(actions: <Widget>[
          ElevatedButton(
            child: const Text("Wyloguj"),
            onPressed: () {
              context.read<AuthenticationService>().signOut();
            },
          )
        ]),
        body: FutureBuilder(
            future: DatabaseService.getHouseId(uid),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return const Loading();
              Object? houseId = snapshot.data;
              return StreamBuilder(
                  //checking shopping lists
                  stream: FirebaseFirestore.instance
                      .collection('houses')
                      .doc(houseId.toString())
                      .collection('shopping-lists')
                      .snapshots(),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (!snapshot.hasData) return const Loading();
                    if (snapshot.data.docs.length == 0) {
                      return const Text('Nie masz jeszcze listy zakupów',
                          style: TextStyle(color: Colors.purple));
                    }
                    Object? houseId = snapshot.data;

                    return ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      // itemExtent: 80,
                      itemCount: snapshot.data.docs.length,
                      itemBuilder: (context, index) {
                        // print(
                        //     'doc id= ' + snapshot.data.docs[index].id);
                        return _buildList(context, snapshot.data.docs[index],
                            uid, houseId.toString(), index);
                      },
                    );
                  });
            }));
  }
}

Widget _buildList(BuildContext context, DocumentSnapshot doc, String userId,
    String houseId, int index) {
  return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          borderRadius: const BorderRadius.all(Radius.circular(20))),
      margin: const EdgeInsets.all(25),
      padding: const EdgeInsets.all(10),
      width: MediaQuery.of(context).size.width - 50,
      height: MediaQuery.of(context).size.height - 50,
      child: Column(children: [
        ListTile(
          onTap: () {},
          title: Row(
            children: [
              Text('Lista zakupow nr ' + (index + 1).toString(),
                  style: const TextStyle(color: Colors.white)),
            ],
          ),
          subtitle: Text('doc id: ' + doc.id),
        ),
        StreamBuilder(
            //checking shopping lists
            stream: FirebaseFirestore.instance
                .collection('houses')
                .doc(houseId.toString())
                .collection('shopping-lists')
                .doc(doc.id)
                .collection('products')
                .snapshots(),
            builder: (context, AsyncSnapshot snapshot) {
              if (!snapshot.hasData) return const Loading();
              if (snapshot.data.docs.length == 0) {
                return const Text('Nie masz produktów na tej liście',
                    style: TextStyle(color: Colors.purple));
              }
              return ListView.builder(
                shrinkWrap: true,
                // itemExtent: 80,
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index) {
                  return _buildListOfProducts(context,
                      snapshot.data.docs[index], userId, houseId.toString());
                },
              );
            })
      ]));
}

Widget _buildListOfProducts(
    BuildContext context, DocumentSnapshot doc, String userId, String houseId) {
  return ListTile(
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20))),
    onTap: () {},
    title: Text(doc['name'], style: const TextStyle(color: Colors.white)),
  );
}
