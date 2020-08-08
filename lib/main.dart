import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project_layout_1/Drawer/drawer_screen.dart';
import 'package:project_layout_1/Login/login_screen.dart';
import 'package:project_layout_1/components/configuration.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light));
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future<FirebaseUser> user;

  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          scaffoldBackgroundColor: kPrimaryColor,
          fontFamily: 'Quicksand',
          textTheme: TextTheme(
              headline1: TextStyle(
                  color: kFontColor, fontSize: 28, fontWeight: FontWeight.bold),
              headline2: TextStyle(
                color: kFontColor.withOpacity(0.5),
                fontSize: 16,
              ),
              button: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 24))),
      home: FutureBuilder(
          future: user,
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case (ConnectionState.active):
                return Scaffold();
              case (ConnectionState.done):
                if (snapshot.data == null)
                  return LoginScreen();
                else
                  return DrawerScreen();
                break;
              case (ConnectionState.none):
                return Scaffold();
              case (ConnectionState.waiting):
                return Scaffold();
              default:
                return Scaffold();
            }
          }),
    );
  }
}
