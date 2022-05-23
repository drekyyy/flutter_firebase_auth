import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;
  DatabaseService(this.uid);

  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');

  Future updateUserData(String name) async {
    return await userCollection
        .doc(uid)
        .set({'userId': uid, 'houseId': uid, 'name': name});
  }

  static Future getHouseId(userid) async {
    dynamic snapshot;
    snapshot =
        await FirebaseFirestore.instance.collection('users').doc(userid).get();
    return snapshot.data()['houseId'];
  }
}
