import * as functions from "firebase-functions";
import * as admin from "firebase-admin";

admin.initializeApp();

const db = admin.firestore();
const fcm = admin.messaging();

export const sendToDeviceOnListCreate= functions.firestore.document("houses/{hId}/shopping-lists/{sLId}").onCreate(async (snap)=> {
  const shoppingList=snap.data();
  const userWhoCreatedListSnapshot = await db.collection("users").doc(shoppingList.createdBy).get();
  const houseMembersSnapshot = await db.collection("users").where("houseId", "==", userWhoCreatedListSnapshot.data()!["houseId"]).where("userId", "!=", shoppingList.createdBy).get();
  const tokens = houseMembersSnapshot.docs.map((snap) => snap.data()["token"]);
  const payload: admin.messaging.MessagingPayload = {
    notification: {
      title: "Nowa lista zakupów!",
      body: `stworzona przez ${userWhoCreatedListSnapshot.data()!["name"]}`,
      icon: "https://i.imgur.com/SGYPHRx.png",
      clickAction: "FLUTTER_NOTIFICATION_CLICK",
    },
  };
  return fcm.sendToDevice(tokens, payload);
});
