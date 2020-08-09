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

  Future<dynamic> checkChatRoomExist(
      String requestemail, String targetemail) async {
    dynamic data;
    final res = await Firestore.instance
        .collection("ChatRoom")
        .document(targetemail + "_" + requestemail)
        .get();

    if (res != null && res.exists) data = res.data;

    return data;
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
