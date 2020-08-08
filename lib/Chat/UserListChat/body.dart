import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_layout_1/Chat/Chatting/chatting_screen.dart';
import 'package:project_layout_1/components/animation_config.dart';
import 'package:project_layout_1/components/configuration.dart';
import 'package:project_layout_1/components/firestore_messaging.dart';
import 'package:project_layout_1/components/loading_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Body extends StatefulWidget {
  const Body({Key key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  bool isLoading = true;
  FirebaseUser user;
  Stream chatroom;
  SharedPreferences shared;
  FirestoreMessaging fm = new FirestoreMessaging();

  @override
  void initState() {
    callChatRoom();
    super.initState();
  }

  void callChatRoom() async {
    user = await FirebaseAuth.instance.currentUser();
    fm.getChatRoom(user.email).then((value) {
      setState(() {
        chatroom = value;
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return AnimatedPositioned(
      duration: duration,
      top: isCollapsed ? 0 : 0.15,
      bottom: isCollapsed ? 0 : 0.15,
      left: isCollapsed ? 0 : 0.6 * size.width,
      right: isCollapsed ? 0 : -0.2 * size.width,
      child: ScaleTransition(
        scale: scaleAnimation,
        child: Material(
          animationDuration: duration,
          borderRadius:
              isCollapsed ? null : BorderRadius.all(Radius.circular(40)),
          elevation: 8,
          color: kPrimaryColor,
          child: isLoading
              ? LoadingScreen()
              : SingleChildScrollView(
                  child: Container(
                    width: size.width,
                    height: size.height,
                    padding: EdgeInsets.only(
                        left: size.width * 0.07,
                        right: size.width * 0.07,
                        top: size.height * 0.08),
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  if (isCollapsed)
                                    animateController.forward();
                                  else
                                    animateController.reverse();

                                  isCollapsed = !isCollapsed;
                                });
                              },
                              child: Icon(
                                Icons.menu,
                                color: kFontColor,
                              ),
                            ),
                            SizedBox(
                              width: size.width * 0.05,
                            ),
                            Text(
                              "User List",
                              style: Theme.of(context).textTheme.headline1,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: size.height * 0.025,
                        ),
                        Container(
                            decoration: BoxDecoration(
                              color: kPrimaryColor,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                    color: kSecondaryColor,
                                    blurRadius: 6.0,
                                    offset: Offset(0.0, 1.0)),
                              ],
                            ),
                            height: size.height * 0.8,
                            width: size.width,
                            child: loadChatroom()),
                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }

  Widget loadChatroom() {
    return StreamBuilder(
      stream: chatroom,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active)
          return _listView(snapshot);
        else
          return Container(
            width: 0,
            height: 0,
          );
      },
    );
  }

  ListView _listView(snapshot) {
    return ListView.builder(
      itemCount: snapshot.data.documents.length,
      physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      itemBuilder: (context, index) {
        return _tile(snapshot.data.documents[index].data['chatroomId'],
            snapshot.data.documents[index].data['users'], Icons.person);
      },
    );
  }

  ListTile _tile(String title, dynamic subtitle, IconData icon) => ListTile(
        title: Text(
            user.email == subtitle[0]
                ? subtitle[1].toString().split('@')[0]
                : subtitle[0].toString().split('@')[0],
            style: TextStyle(
                fontWeight: FontWeight.w600, fontSize: 17, color: kFontColor)),
        leading: Icon(
          icon,
          color: kFontColor,
        ),
        trailing: Icon(
          Icons.arrow_right,
          color: kFontColor,
        ),
        onTap: () async {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) {
              return ChattingScreen(
                email: user.email == subtitle[0] ? subtitle[1] : subtitle[0],
                chatRoomId: title,
                currentuseremail: user.email,
              );
            },
          ));
        },
      );
}