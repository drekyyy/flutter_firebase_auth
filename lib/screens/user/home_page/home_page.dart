import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_shopping_list/screens/user/home_page/components/hamburger_menu.dart';
import 'package:flutter_shopping_list/services/authentication_service.dart';
import 'package:flutter_shopping_list/shared/custom_show_dialog.dart';
import 'package:flutter_shopping_list/shared/custom_show_dialog_with_fields.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:provider/provider.dart';
import '../../../main.dart';
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
  initState() {
    super.initState();

    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) {
      if (message != null) {
        return null;
      }
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null && !kIsWeb) {
        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              channelDescription: channel.description,
              // TODO add a proper drawable resource to android, for now using
              //      one that already exists in example app.
              icon: 'launch_background',
            ),
          ),
        );

        final snackbar = SnackBar(
            content: Text('${notification.title} ${notification.body}'),
            action: SnackBarAction(label: 'ok', onPressed: () {}));

        ScaffoldMessenger.of(context).showSnackBar(snackbar);
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
      return null;
    });
  }

  Widget build(BuildContext context) {
    final String uid = Provider.of<SimpleUser?>(context)!.uid;

    return Scaffold(
        drawer: const HamburgerMenu(),
        appBar: AppBar(
            title: Center(
                child: Image.asset("assets/logo-white.png",
                    fit: BoxFit.contain, height: 30)),
            actions: <Widget>[
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
                      .orderBy('timestamp')
                      .snapshots(),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (!snapshot.hasData) return const Loading();
                    if (snapshot.data.docs.length == 0) {
                      return const Center(
                          child: Text('Nie masz jeszcze listy zakupów',
                              style: TextStyle(color: Colors.white)));
                    }

                    return Container(
                        padding: const EdgeInsets.only(top: 15),
                        height: MediaQuery.of(context).size.height * 0.78,
                        child: Swiper(
                            itemCount: snapshot.data.docs.length,
                            itemBuilder: (context, index) {
                              return Container(
                                padding: const EdgeInsets.only(bottom: 25),
                                child: _buildShoppingList(
                                    context,
                                    snapshot.data.docs[index],
                                    uid,
                                    houseId,
                                    index),
                              );
                            },
                            scale: 0.92,
                            viewportFraction: 0.95,
                            pagination: const SwiperPagination(
                                builder: DotSwiperPaginationBuilder(
                                    color: Colors.grey,
                                    activeColor: Colors.white),
                                alignment: Alignment.bottomCenter)));
                  });
            }));
  }
}

Widget _buildShoppingList(BuildContext context, DocumentSnapshot listDoc,
    String userId, String houseId, int index) {
  return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.white, width: 2),
          borderRadius: const BorderRadius.all(Radius.circular(20))),
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(10),
      //width: MediaQuery.of(context).size.width - 50,
      //height: MediaQuery.of(context).size.height - 540,
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
                              customShowDialog(
                                  context,
                                  'Czy usunąć tą liste?',
                                  DatabaseService.deleteShoppingList,
                                  houseId,
                                  listDoc.id,
                                  '');
                            },
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
                          customShowDialogWithFields(
                              context,
                              'Zmiana nazwy listy',
                              "Nowa nazwa listy",
                              20,
                              DatabaseService.changeNameOfShoppingList,
                              houseId,
                              listDoc.id.toString());
                        },
                        child: Text(listDoc['name'],
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 16))),
                  ],
                )),
                TextButton(
                    onPressed: () {
                      customShowDialogWithFields(
                          context,
                          'Dodaj produkt',
                          'Nazwa produktu',
                          30,
                          DatabaseService.addProductToShoppingList,
                          houseId,
                          listDoc.id.toString());
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
                          listDoc.id.toString(),
                          snapshot.data.docs[index],
                          userId,
                          houseId.toString());
                    },
                  );
                })
          ])));
}

Widget _buildListOfProducts(BuildContext context, int index, String listId,
    DocumentSnapshot productDoc, String userId, String houseId) {
  return ListTile(
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20))),
    onTap: () {},
    onLongPress: () async {
      customShowDialog(
          context,
          'Czy usunąć ${productDoc['name']}?',
          DatabaseService.deleteProductFromShoppingList,
          houseId,
          listId,
          productDoc.id);
    },
    title: Text('${index + 1}. ${productDoc['name']}',
        style: const TextStyle(color: Colors.white)),
  );
}
