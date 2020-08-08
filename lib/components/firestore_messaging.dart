import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreMessaging {
  createChatRoom(String chatRoomId, chatRoomMap) async {
    await Firestore.instance
        .collection("ChatRoom")
        .document(chatRoomId)
        .setData(chatRoomMap)
        .catchError((onError) {
      print(onError.toString());
    });
  }

  setConversationMessage(String chatRoomId, messageMap) async {
    await Firestore.instance
        .collection("ChatRoom")
        .document(chatRoomId)
        .collection("chats")
        .add(messageMap)
        .catchError((onError) {
      print(onError.toString());
    });
  }

  getConversationMessage(String chatRoomId) async {
    return Firestore.instance
        .collection("ChatRoom")
        .document(chatRoomId)
        .collection("chats")
        .orderBy("time", descending: true)
        .snapshots();
  }

  getChatRoom(String email) async {
    return Firestore.instance
        .collection("ChatRoom")
        .where("users", arrayContains: email)
        .snapshots();
  }
}
