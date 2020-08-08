import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_layout_1/Drawer/drawer_screen.dart';
import 'package:project_layout_1/HttpController/http_request.dart';
import 'package:project_layout_1/components/configuration.dart';
import 'package:project_layout_1/components/toast.dart';
import 'package:toast/toast.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  String email = "", name = "", phone = "", password = "", confpass = "";
  String whichTap = "";
  bool passwordInvisible = true;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: size.width,
          height: size.height,
          child: Column(children: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                  left: size.width * 0.07,
                  right: size.width * 0.07,
                  top: size.height * 0.08),
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
                  )
                ],
              ),
            ),
            SizedBox(
              height: size.height * 0.04,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: size.width * 0.07),
              width: size.width,
              child: Text(
                "Create Account",
                style: Theme.of(context).textTheme.headline1,
              ),
            ),
            SizedBox(
              height: size.height * 0.01,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: size.width * 0.07),
              width: size.width,
              child: Text(
                "Please fill in the form below",
                style: Theme.of(context).textTheme.headline2,
              ),
            ),
            SizedBox(
              height: size.height * 0.05,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              margin: EdgeInsets.symmetric(horizontal: size.width * 0.07),
              decoration: whichTap == "fullname"
                  ? BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: kSecondaryColor.withAlpha(70))
                  : BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: kPrimaryColor),
              child: TextField(
                onTap: () {
                  setState(() {
                    whichTap = "fullname";
                  });
                },
                onChanged: (value) {
                  name = value;
                },
                onSubmitted: (value) {
                  setState(() {
                    whichTap = "";
                  });
                },
                style:
                    TextStyle(color: kFontColor, fontWeight: FontWeight.w500),
                decoration: InputDecoration(
                    icon: Icon(
                      Icons.person_outline,
                      color: kFontColor.withOpacity(0.87),
                    ),
                    border: InputBorder.none,
                    labelText: "FULL NAME",
                    labelStyle: TextStyle(color: kFontColor.withOpacity(0.5))),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              margin: EdgeInsets.symmetric(horizontal: size.width * 0.07),
              decoration: whichTap == "phone"
                  ? BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: kSecondaryColor.withAlpha(70))
                  : BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: kPrimaryColor),
              child: TextField(
                onTap: () {
                  setState(() {
                    whichTap = "phone";
                  });
                },
                onChanged: (value) {
                  phone = value;
                },
                onSubmitted: (value) {
                  setState(() {
                    whichTap = "";
                  });
                },
                style:
                    TextStyle(color: kFontColor, fontWeight: FontWeight.w500),
                decoration: InputDecoration(
                    icon: Icon(
                      Icons.phone_iphone,
                      color: kFontColor.withOpacity(0.87),
                    ),
                    border: InputBorder.none,
                    labelText: "PHONE",
                    labelStyle: TextStyle(color: kFontColor.withOpacity(0.5))),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              margin: EdgeInsets.symmetric(horizontal: size.width * 0.07),
              decoration: whichTap == "email"
                  ? BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: kSecondaryColor.withAlpha(70))
                  : BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: kPrimaryColor),
              child: TextField(
                onTap: () {
                  setState(() {
                    whichTap = "email";
                  });
                },
                onChanged: (value) {
                  email = value;
                },
                onSubmitted: (value) {
                  setState(() {
                    whichTap = "";
                  });
                },
                style:
                    TextStyle(color: kFontColor, fontWeight: FontWeight.w500),
                decoration: InputDecoration(
                    icon: Icon(
                      Icons.email,
                      color: kFontColor.withOpacity(0.87),
                    ),
                    border: InputBorder.none,
                    labelText: "EMAIL",
                    labelStyle: TextStyle(color: kFontColor.withOpacity(0.5))),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              margin: EdgeInsets.symmetric(horizontal: size.width * 0.07),
              decoration: whichTap == "password"
                  ? BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: kSecondaryColor.withAlpha(70))
                  : BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: kPrimaryColor),
              child: TextField(
                onTap: () {
                  setState(() {
                    whichTap = "password";
                  });
                },
                onChanged: (value) {
                  password = value;
                },
                onSubmitted: (value) {
                  setState(() {
                    whichTap = "";
                  });
                },
                obscureText: passwordInvisible,
                style:
                    TextStyle(color: kFontColor, fontWeight: FontWeight.w500),
                decoration: InputDecoration(
                    icon: Icon(
                      whichTap == "password"
                          ? Icons.lock_open
                          : Icons.lock_outline,
                      color: kFontColor.withOpacity(0.87),
                    ),
                    suffixIcon: GestureDetector(
                      onTap: () {
                        setState(() {
                          passwordInvisible = passwordInvisible ? false : true;
                        });
                      },
                      child: Icon(
                        passwordInvisible
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: kFontColor.withOpacity(0.87),
                      ),
                    ),
                    border: InputBorder.none,
                    labelText: "PASSWORD",
                    labelStyle: TextStyle(color: kFontColor.withOpacity(0.5))),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              margin: EdgeInsets.symmetric(horizontal: size.width * 0.07),
              decoration: whichTap == "confpass"
                  ? BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: kSecondaryColor.withAlpha(70))
                  : BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: kPrimaryColor),
              child: TextField(
                onTap: () {
                  setState(() {
                    whichTap = "confpass";
                  });
                },
                onSubmitted: (value) {
                  setState(() {
                    whichTap = "";
                  });
                },
                onChanged: (value) {
                  confpass = value;
                },
                obscureText: true,
                style:
                    TextStyle(color: kFontColor, fontWeight: FontWeight.w500),
                decoration: InputDecoration(
                    icon: Icon(
                      whichTap == "confpass"
                          ? Icons.lock_open
                          : Icons.lock_outline,
                      color: kFontColor.withOpacity(0.87),
                    ),
                    border: InputBorder.none,
                    labelText: "CONFIRM PASSWORD",
                    labelStyle: TextStyle(color: kFontColor.withOpacity(0.5))),
              ),
            ),
            SizedBox(
              height: size.height * 0.1,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Container(
                width: size.width * 0.6,
                color: kAccentColor,
                child: FlatButton(
                  onPressed: () async {
                    if (name.isEmpty ||
                        phone.isEmpty ||
                        email.isEmpty ||
                        password.isEmpty ||
                        confpass.isEmpty) {
                      showToast("Please fill in all the form field!", context,
                          duration: 5, gravity: Toast.BOTTOM);
                      return;
                    } else if (password != confpass) {
                      showToast("Password does not matching!", context,
                          duration: 5, gravity: Toast.BOTTOM);
                      return;
                    }

                    try {
                      await FirebaseAuth.instance
                          .createUserWithEmailAndPassword(
                              email: email, password: password)
                          .then((value) async {
                        dynamic credential = {
                          "fullname": name,
                          "phoneno": phone,
                          "email": email,
                          "password": password,
                          "id": value.user.uid
                        };

                        await registeruser(credential, context)
                            .then((value) async {
                          if (value) {
                            await login({"email": email, "password": password},
                                    context)
                                .then((value) {
                              if (value) {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) {
                                    return DrawerScreen();
                                  },
                                ));
                              }
                            });
                          }
                        });
                      });
                    } catch (e) {
                      showToast(e.message, context,
                          duration: 5, gravity: Toast.BOTTOM);
                    }
                  },
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                  child: Text("SIGN UP"),
                ),
              ),
            ),
            SizedBox(
              height: size.height * 0.05,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Already have an account? ",
                  style: Theme.of(context).textTheme.headline2,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    "Login",
                    style: TextStyle(
                        color: kAccentColor, fontWeight: FontWeight.w700),
                  ),
                ),
              ],
            ),
          ]),
        ),
      ),
    );
  }
}
