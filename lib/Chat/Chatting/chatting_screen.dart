import 'package:project_layout_1/components/firestore_messaging.dart';
import 'package:flutter/material.dart';
import 'package:project_layout_1/components/configuration.dart';
import 'package:project_layout_1/components/loading_screen.dart';
import 'package:project_layout_1/components/toast.dart';
import 'package:toast/toast.dart';

class ChattingScreen extends StatefulWidget {
  final String email;
  final String currentuseremail;
  final String chatRoomId;

  const ChattingScreen(
      {Key key, @required this.email, this.chatRoomId, this.currentuseremail})
      : super(key: key);

  @override
  _ChattingScreenState createState() => _ChattingScreenState();
}

class _ChattingScreenState extends State<ChattingScreen> {
  bool isLoading = false;
  FirestoreMessaging fm = new FirestoreMessaging();
  TextEditingController msg = new TextEditingController();
  Stream chatMessage;

  sendMessage() async {
    if (msg.text.isNotEmpty) {
      var messageMap = {
        "message": msg.text,
        "sendBy": widget.currentuseremail,
        "time": DateTime.now().millisecondsSinceEpoch,
      };
      await fm.setConversationMessage(widget.chatRoomId, messageMap);
    } else {
      showToast("Write a message please!", context,
          duration: 5, gravity: Toast.BOTTOM);
    }
  }

  @override
  void initState() {
    fm.getConversationMessage(widget.chatRoomId).then((value) {
      setState(() {
        chatMessage = value;
        isLoading = false;
      });
    });
    super.initState();
  }

  Widget chatMessageList() {
    return StreamBuilder(
      stream: chatMessage,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active)
          return listMessage(snapshot);
        else
          return Container(
            width: 0,
            height: 0,
          );
      },
    );
  }

  Widget listMessage(snapshot) {
    return ListView.builder(
      reverse: true,
      itemCount: snapshot.data.documents.length,
      physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      itemBuilder: (context, index) {
        bool isByMe = widget.currentuseremail ==
            snapshot.data.documents[index].data["sendBy"];
        return messageTile(
            snapshot.data.documents[index].data["message"], isByMe);
      },
    );
  }

  Widget messageTile(String chat, bool sendByMe) {
    Size size = MediaQuery.of(context).size;
    return Container(
      alignment: sendByMe ? Alignment.centerRight : Alignment.centerLeft,
      width: size.width,
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              bottomLeft: sendByMe ? Radius.circular(10) : Radius.circular(0),
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
              bottomRight: sendByMe ? Radius.circular(0) : Radius.circular(10)),
          gradient: LinearGradient(
            colors: sendByMe
                ? [Color(0xff007ef4), Color(0xff2a75bc)]
                : [Color(0x1affffff), Color(0x1affffff)],
          ),
        ),
        margin: EdgeInsets.symmetric(vertical: size.height * 0.01),
        child: Text(
          chat,
          style: TextStyle(color: kFontColor, fontSize: 17),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return isLoading
        ? LoadingScreen()
        : Scaffold(
            body: SingleChildScrollView(
              child: Container(
                width: size.width,
                height: size.height,
                child: Stack(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(
                          left: size.width * 0.07,
                          right: size.width * 0.07,
                          top: size.height * 0.08,
                          bottom: size.height * 0.08),
                      child: Column(
                        children: <Widget>[
                          Container(
                            child: Row(
                              children: <Widget>[
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Icon(
                                    Icons.arrow_back,
                                    color: kFontColor,
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  widget.email.split('@')[0],
                                  style: TextStyle(
                                      color: kFontColor, fontSize: 20),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: size.height * 0.025,
                          ),
                          Container(
                              height: size.height * 0.75,
                              child: chatMessageList()),
                        ],
                      ),
                    ),
                    Container(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        color: Color(0x54ffffff),
                        padding: EdgeInsets.symmetric(horizontal: 24),
                        height: size.height * 0.07,
                        width: size.width,
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: TextField(
                                style: TextStyle(color: kFontColor),
                                decoration: InputDecoration(
                                    hintText: "Type message...",
                                    border: InputBorder.none),
                                onSubmitted: (value) async {
                                  await sendMessage();
                                  msg.clear();
                                },
                                controller: msg,
                              ),
                            ),
                            GestureDetector(
                              onTap: () async {
                                await sendMessage();
                                msg.clear();
                              },
                              child: Icon(
                                Icons.send,
                                color: kAccentColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
