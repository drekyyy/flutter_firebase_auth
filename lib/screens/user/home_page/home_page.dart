import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
        bottomSheet: Container(
            height: 70,
            child: Center(
                child: TextButton(
                    onPressed: () async {
                      await DatabaseService.createShoppingList(uid);
                    },
                    child: Column(
                      children: const [
                        Icon(Icons.add_box),
                        SizedBox(height: 5),
                        Text('Nowa lista',
                            style: TextStyle(
                                color: Colors.white, fontFamily: 'Roboto')),
                      ],
                    )))),
        body: FutureBuilder(
            //getting house id of user
            future: DatabaseService.getHouseId(uid),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return const Loading();
              String houseId = snapshot.data.toString();
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
                      return const Center(
                          child: Text('Nie masz jeszcze listy zakupów',
                              style: TextStyle(color: Colors.white)));
                    }
                    //building horizontal listview for each shopping list
                    return ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: snapshot.data.docs.length,
                      itemBuilder: (context, index) {
                        return _buildShoppingList(context,
                            snapshot.data.docs[index], uid, houseId, index);
                      },
                    );
                  });
            }));
  }
}

Widget _buildShoppingList(BuildContext context, DocumentSnapshot listDoc,
    String userId, String houseId, int index) {
  return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          borderRadius: const BorderRadius.all(Radius.circular(0))),
      margin: const EdgeInsets.only(top: 25, left: 25, right: 25, bottom: 100),
      //padding: const EdgeInsets.all(10),
      width: MediaQuery.of(context).size.width - 50,
      height: MediaQuery.of(context).size.height - 340,
      child: SingleChildScrollView(
          physics: ScrollPhysics(),
          child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        padding: const EdgeInsets.only(left: 5),
                        child: TextButton(
                            onLongPress: () {
                              showDialog<String>(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                  title: const Text('Czy usunąć tą liste?',
                                      style: TextStyle(
                                          color: Color.fromARGB(
                                              255, 165, 214, 167))),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Center(
                                          child: TextButton(
                                        onPressed: () async {
                                          await DatabaseService
                                              .deleteShoppingList(
                                                  houseId, listDoc.id);
                                        },
                                        child: const Text('Tak',
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 165, 214, 167))),
                                      )),
                                    ],
                                  ),
                                ),
                              );
                            }, //tutaj dodac usuwanie listy zakupow ^
                            onPressed: () {},
                            child: Row(children: [
                              const Icon(Icons.numbers, size: 18),
                              Text('${index + 1}  ',
                                  style: const TextStyle(color: Colors.white)),
                              const Icon(Icons.date_range, size: 18),
                              Text(' ${listDoc['dateWhenCreated']}  ',
                                  style: const TextStyle(color: Colors.white)),
                              const Icon(Icons.timer, size: 18),
                              Text(' ${listDoc['hourWhenCreated']}',
                                  style: const TextStyle(color: Colors.white)),
                            ]))),
                    TextButton(
                        onPressed: () {},
                        onLongPress: () {
                          final _formKey = GlobalKey<FormState>();
                          final TextEditingController listNameController =
                              TextEditingController();
                          String listName;
                          String? firebaseResponse = '';
                          showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              title: const Text('Zmiana nazwy listy',
                                  style: TextStyle(
                                      color:
                                          Color.fromARGB(255, 165, 214, 167))),
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
                                              return 'List name too long';
                                            }

                                            return null;
                                          },
                                          onChanged: (val) {
                                            listName = val;
                                          },
                                          controller: listNameController,
                                          decoration: const InputDecoration(
                                            labelText: "Nowa nazwa listy",
                                          )),
                                      Center(
                                          child: TextButton(
                                        onPressed: () async {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            firebaseResponse =
                                                await DatabaseService
                                                    .changeNameOfShoppingList(
                                                        houseId,
                                                        listDoc.id.toString(),
                                                        listNameController.text
                                                            .trim());
                                            Navigator.pop(context);
                                          } else {
                                            Text(firebaseResponse.toString());
                                            firebaseResponse = '';
                                          }
                                        },
                                        child: const Text('Ok',
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 165, 214, 167))),
                                      )),
                                    ],
                                  )),
                            ),
                          );
                        },
                        child: Text(listDoc['name'],
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 16))),
                  ],
                )),
                TextButton(
                    onPressed: () {
                      final _formKey = GlobalKey<FormState>();
                      final TextEditingController productNameController =
                          TextEditingController();
                      String productName;
                      String? firebaseResponse = '';
                      showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          title: const Text('Dodaj produkt',
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
                                        if (val.length > 30) {
                                          return 'Product name too long';
                                        }

                                        return null;
                                      },
                                      onChanged: (val) {
                                        productName = val;
                                      },
                                      controller: productNameController,
                                      decoration: const InputDecoration(
                                        labelText: "Nazwa produktu",
                                      )),
                                  Center(
                                      child: TextButton(
                                    onPressed: () async {
                                      if (_formKey.currentState!.validate()) {
                                        firebaseResponse = await DatabaseService
                                            .addProductToShoppingList(
                                                houseId,
                                                listDoc.id.toString(),
                                                productNameController.text
                                                    .trim());
                                        Navigator.pop(context);
                                      } else {
                                        Text(firebaseResponse.toString());
                                        firebaseResponse = '';
                                      }
                                    },
                                    child: const Text('Ok',
                                        style: TextStyle(
                                            color: Color.fromARGB(
                                                255, 165, 214, 167))),
                                  )),
                                ],
                              )),
                        ),
                      );
                    },
                    child: Column(children: const [
                      Icon(Icons.add),
                      Text('Dodaj'),
                      Text('Produkt')
                    ]))
              ],
            ),
            SizedBox(
                height: 2,
                width: MediaQuery.of(context).size.width - 50,
                child: const DecoratedBox(
                  decoration: BoxDecoration(color: Colors.white),
                )),
            StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('houses')
                    .doc(houseId.toString())
                    .collection('shopping-lists')
                    .doc(listDoc.id.toString())
                    .collection('products')
                    .snapshots(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (!snapshot.hasData) return const Loading();
                  if (snapshot.data.docs.length == 0) {
                    return Container(
                        padding: const EdgeInsets.only(top: 20),
                        child: const Text('Nie masz produktów na tej liście',
                            style: TextStyle(color: Colors.white)));
                  }
                  return ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: snapshot.data.docs.length,
                    itemBuilder: (context, index) {
                      return _buildListOfProducts(
                          context,
                          index,
                          snapshot.data.docs[index],
                          userId,
                          houseId.toString());
                    },
                  );
                }),
          ])));
}

// usunac dodaj produkt text, zostawic sam plus. dodac smietnik usuniecie listy, na longpress usuniecie produktu
Widget _buildListOfProducts(BuildContext context, int index,
    DocumentSnapshot productDoc, String userId, String houseId) {
  return ListTile(
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20))),
    onTap: () {},
    title: Text('${index + 1}. ${productDoc['name']}',
        style: const TextStyle(color: Colors.white)),
  );
}
