import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project_layout_1/Chat/UserListChat/userlistchat_screen.dart';
import 'package:project_layout_1/Dashboard/dashboard_screen.dart';
import 'package:project_layout_1/HttpController/http_request.dart';
import 'package:project_layout_1/Setting/setting_screen.dart';
import 'package:project_layout_1/components/animation_config.dart';
import 'package:project_layout_1/components/configuration.dart';
import 'package:project_layout_1/components/loading_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DrawerScreen extends StatefulWidget {
  const DrawerScreen({
    Key key,
  }) : super(key: key);

  @override
  _DrawerScreenState createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen>
    with SingleTickerProviderStateMixin {
  Widget thebody;
  dynamic data;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    setState(() {
      thebody = DashboardScreen();
    });
    animateController = AnimationController(vsync: this, duration: duration);
    scaleAnimation =
        Tween<double>(begin: 1, end: 0.8).animate(animateController);
    menuScaleAnimation =
        Tween<double>(begin: 0.5, end: 1).animate(animateController);
    slideAnimation = Tween<Offset>(begin: Offset(-1, 0), end: Offset(0, 0))
        .animate(animateController);
    callAPI();
  }

  @override
  void dispose() {
    animateController.dispose();
    super.dispose();
  }

  void callAPI() async {
    SharedPreferences shared = await SharedPreferences.getInstance();
    var json = await authorizedgetrequest(
        "user/getuserdetail?t=${shared.getString('token')}", context);
    setState(() {
      data = json;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return isLoading
        ? LoadingScreen()
        : Scaffold(
            backgroundColor: Color(0xff262626),
            body: Stack(
              children: <Widget>[
                SlideTransition(
                  position: slideAnimation,
                  child: ScaleTransition(
                    scale: menuScaleAnimation,
                    child: SingleChildScrollView(
                      child: Container(
                        color: Color(0xff262626),
                        width: size.width,
                        height: size.height,
                        child: Padding(
                          padding: EdgeInsets.only(
                              top: size.height * 0.1,
                              left: size.width * 0.06,
                              right: size.width * 0.39),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                CircleAvatar(
                                  maxRadius: size.width * 0.13,
                                  backgroundColor: kSecondaryColor,
                                  foregroundColor: kPrimaryColor,
                                  child: Text(
                                    "AR",
                                    style: TextStyle(fontSize: 30),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.only(top: size.height * 0.04),
                                  child: Text(
                                    data != null
                                        ? data['fullname'].toString().length >=
                                                21
                                            ? data['fullname']
                                                    .toString()
                                                    .substring(0, 16) +
                                                " ..."
                                            : data['fullname']
                                        : " - ",
                                    style: TextStyle(
                                        color: kFontColor,
                                        fontSize: 22,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                                SizedBox(
                                  height: 2,
                                ),
                                Text(
                                  data != null
                                      ? data['email']
                                                  .toString()
                                                  .split('@')[0]
                                                  .length >=
                                              23
                                          ? data['email']
                                                  .toString()
                                                  .split('@')[0]
                                                  .substring(0, 18) +
                                              " ..."
                                          : data['email']
                                              .toString()
                                              .split('@')[0]
                                      : " - ",
                                  style: TextStyle(
                                      color: kFontColor.withOpacity(0.3),
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500),
                                ),
                                SizedBox(
                                  height: size.height * 0.07,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      thebody = DashboardScreen();
                                    });
                                  },
                                  child: Row(
                                    children: <Widget>[
                                      Icon(
                                        Icons.home,
                                        color: kFontColor,
                                        size: 20,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text("Home",
                                          style: TextStyle(
                                              color: kFontColor, fontSize: 20)),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 10),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      thebody = UserChatListScreen();
                                    });
                                  },
                                  child: Row(
                                    children: <Widget>[
                                      Icon(
                                        Icons.message,
                                        color: kFontColor,
                                        size: 20,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text("Messages",
                                          style: TextStyle(
                                              color: kFontColor, fontSize: 20)),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text("Utility Bills",
                                    style: TextStyle(
                                        color: kFontColor, fontSize: 20)),
                                SizedBox(height: 10),
                                Text("Funds Transfer",
                                    style: TextStyle(
                                        color: kFontColor, fontSize: 20)),
                                SizedBox(height: 10),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      thebody = SettingScreen();
                                    });
                                  },
                                  child: Row(
                                    children: <Widget>[
                                      Icon(
                                        Icons.settings,
                                        color: kFontColor,
                                        size: 20,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text("Setting",
                                          style: TextStyle(
                                              color: kFontColor, fontSize: 20)),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: size.height * 0.25,
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    FirebaseAuth.instance.signOut();
                                    SharedPreferences shared =
                                        await SharedPreferences.getInstance();
                                    bool cleared = await shared.clear();
                                    if (cleared) {
                                      setState(() {
                                        if (isCollapsed)
                                          animateController.forward();
                                        else
                                          animateController.reverse();

                                        isCollapsed = !isCollapsed;
                                      });

                                      if (Navigator.of(context).canPop()) {
                                        Navigator.of(context)
                                            .popUntil((route) => route.isFirst);
                                      } else {
                                        SystemNavigator.pop();
                                      }
                                    }
                                  },
                                  child: Row(
                                    children: <Widget>[
                                      Icon(
                                        Icons.exit_to_app,
                                        color: kFontColor,
                                        size: 20,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        "Log Out",
                                        style: TextStyle(
                                            color: kFontColor, fontSize: 20),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                thebody,
              ],
            ),
          );
  }
}
