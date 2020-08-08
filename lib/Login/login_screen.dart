import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:project_layout_1/Drawer/drawer_screen.dart';
import 'package:project_layout_1/HttpController/http_request.dart';
import 'package:project_layout_1/Signup/signup_screen.dart';
import 'package:project_layout_1/components/configuration.dart';
import 'package:project_layout_1/components/loading_screen.dart';
import 'package:project_layout_1/components/toast.dart';
import 'package:toast/toast.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String whichTap = "";
  bool isPasswordInvisible = true;

  String email = "";
  String password = "";

  bool isLoading;

  @override
  void initState() {
    super.initState();
    isLoading = false;
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SvgPicture.asset(
                      "assets/icons/login.svg",
                      height: size.height * 0.3,
                    ),
                    SizedBox(
                      height: size.height * 0.05,
                    ),
                    Container(
                      width: size.width,
                      margin:
                          EdgeInsets.symmetric(horizontal: size.width * 0.1),
                      child: Text(
                        "Login",
                        style: Theme.of(context).textTheme.headline1,
                        textAlign: TextAlign.start,
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.01,
                    ),
                    Container(
                      width: size.width,
                      margin:
                          EdgeInsets.symmetric(horizontal: size.width * 0.1),
                      child: Text(
                        "Please sign in to continue",
                        style: Theme.of(context).textTheme.headline2,
                        textAlign: TextAlign.start,
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.05,
                    ),
                    Container(
                        decoration: BoxDecoration(
                            color: whichTap != "email"
                                ? kPrimaryColor
                                : kSecondaryColor.withAlpha(70),
                            borderRadius: BorderRadius.circular(10)),
                        width: size.width,
                        margin:
                            EdgeInsets.symmetric(horizontal: size.width * 0.1),
                        child: TextField(
                          controller: TextEditingController(text: email),
                          onTap: () {
                            setState(() {
                              whichTap = "email";
                            });
                          },
                          onChanged: (value) {
                            email = value;
                          },
                          onSubmitted: (value) {
                            whichTap = "";
                          },
                          style: TextStyle(
                              color: kFontColor, fontWeight: FontWeight.w500),
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              prefixIcon: Icon(
                                Icons.email,
                                color: kFontColor.withOpacity(0.5),
                              ),
                              labelText: "EMAIL",
                              labelStyle: TextStyle(
                                  color: kFontColor.withOpacity(0.5))),
                        )),
                    Container(
                        decoration: BoxDecoration(
                            color: whichTap != "password"
                                ? kPrimaryColor
                                : kSecondaryColor.withAlpha(70),
                            borderRadius: BorderRadius.circular(10)),
                        width: size.width,
                        margin:
                            EdgeInsets.symmetric(horizontal: size.width * 0.1),
                        child: TextField(
                          controller: TextEditingController(text: password),
                          obscureText: isPasswordInvisible,
                          onTap: () {
                            setState(() {
                              whichTap = "password";
                            });
                          },
                          onChanged: (value) {
                            password = value;
                          },
                          onSubmitted: (value) {
                            whichTap = "";
                          },
                          style: TextStyle(
                              color: kFontColor, fontWeight: FontWeight.w500),
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              prefixIcon: Icon(
                                whichTap == "password"
                                    ? Icons.lock_open
                                    : Icons.lock_outline,
                                color: kFontColor.withOpacity(0.5),
                              ),
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isPasswordInvisible =
                                        isPasswordInvisible ? false : true;
                                  });
                                },
                                child: Icon(
                                  isPasswordInvisible
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: kFontColor.withOpacity(0.5),
                                ),
                              ),
                              labelText: "PASSWORD",
                              labelStyle: TextStyle(
                                  color: kFontColor.withOpacity(0.5))),
                        )),
                    SizedBox(
                      height: size.height * 0.03,
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Container(
                        width: size.width * 0.6,
                        color: kAccentColor,
                        child: FlatButton(
                          padding: EdgeInsets.symmetric(
                              vertical: 20, horizontal: 40),
                          onPressed: () async {
                            if (email == "" || password == "") {
                              showToast(
                                  "Please fill in all the field!", context,
                                  duration: 5, gravity: Toast.BOTTOM);
                              return;
                            }
                            setState(() {
                              isLoading = true;
                            });

                            dynamic data = {
                              "email": email,
                              "password": password
                            };
                            await login(data, context).then((value) {
                              setState(() {
                                isLoading = false;
                              });
                              if (value)
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) {
                                    return DrawerScreen();
                                  },
                                ));
                            });
                          },
                          child: Text("LOGIN"),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    Text(
                      "Forgot Password?",
                      style: TextStyle(
                          color: kAccentColor, fontWeight: FontWeight.w700),
                    ),
                    SizedBox(
                      height: size.height * 0.05,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Don't have an account? ",
                          style: Theme.of(context).textTheme.headline2,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) {
                                return SignupScreen();
                              },
                            ));
                          },
                          child: Text(
                            "Sign Up",
                            style: TextStyle(
                                color: kAccentColor,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
  }
}
