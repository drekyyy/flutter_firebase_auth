import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;
  DatabaseService(this.uid);

  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');

  Future createUserDocumentInDatabase(String name) async {
    await userCollection
        .doc(uid)
        .set({'userId': uid, 'houseId': uid, 'name': name});
  }

  Future createHouseInDatabase() async {
    await FirebaseFirestore.instance.collection('houses').doc(uid).set({});
  }

  static Future getHouseId(userid) async {
    dynamic snapshot;
    snapshot =
        await FirebaseFirestore.instance.collection('users').doc(userid).get();
    return snapshot.data()['houseId'];
  }

  static Future checkIfHouseExists(String houseId) async {
    dynamic userDocRef =
        await FirebaseFirestore.instance.collection('users').doc(houseId);
    dynamic doc = await userDocRef.get();
    if (doc.exists) {
      return true;
    } else {
      return false;
    }
  }

  static Future updateUserHouseId(String houseId, String userId) async {
    return await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .update({'houseId': houseId});
  }
}
