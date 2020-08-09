import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:project_layout_1/Login/login_screen.dart';
import 'package:project_layout_1/Signup/signup_screen.dart';
import 'package:project_layout_1/UI_Components/menu_button.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Container(
        width: size.width,
        height: size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SvgPicture.asset(
              "assets/icons/welcome.svg",
              height: size.height * 0.35,
            ),
            SizedBox(
              height: size.height * 0.05,
            ),
            Text(
              "Welcome",
              style: Theme.of(context).textTheme.headline1,
            ),
            Text(
              "to project-lapang",
              style: Theme.of(context).textTheme.headline2,
            ),
            SizedBox(
              height: size.height * 0.05,
            ),
            MenuButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) {
                    return LoginScreen();
                  },
                ));
              },
              title: "LOGIN",
            ),
            SizedBox(
              height: size.height * 0.03,
            ),
            MenuButton(
              title: "REGISTER",
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) {
                    return SignupScreen();
                  },
                ));
              },
            ),
          ],
        ),
      ),
    );
  }
}
