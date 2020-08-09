import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_layout_1/Drawer/drawer_screen.dart';
import 'package:project_layout_1/HttpController/http_request.dart';
import 'package:project_layout_1/UI_Components/input_container.dart';
import 'package:project_layout_1/UI_Components/menu_button.dart';
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
            InputContainer(
              deco: whichTap == "fullname"
                  ? BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: kSecondaryColor.withAlpha(70))
                  : BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: kPrimaryColor),
              icon: Icons.person_outline,
              value: name,
              label: "FULL NAME",
              onChanged: (value) {
                name = value;
              },
              onSubmitted: (value) {
                whichTap = "";
              },
              onTap: () {
                whichTap = "fullname";
              },
            ),
            InputContainer(
              deco: whichTap == "phone"
                  ? BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: kSecondaryColor.withAlpha(70))
                  : BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: kPrimaryColor),
              icon: Icons.phone_iphone,
              value: phone,
              label: "PHONE NO",
              onChanged: (value) {
                phone = value;
              },
              onSubmitted: (value) {
                whichTap = "";
              },
              onTap: () {
                whichTap = "phone";
              },
            ),
            InputContainer(
              deco: whichTap == "email"
                  ? BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: kSecondaryColor.withAlpha(70))
                  : BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: kPrimaryColor),
              icon: Icons.email,
              value: email,
              label: "EMAIL",
              onChanged: (value) {
                email = value;
              },
              onSubmitted: (value) {
                whichTap = "";
              },
              onTap: () {
                whichTap = "email";
              },
            ),
            InputContainer(
              deco: whichTap == "password"
                  ? BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: kSecondaryColor.withAlpha(70))
                  : BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: kPrimaryColor),
              icon:
                  whichTap == "password" ? Icons.lock_open : Icons.lock_outline,
              value: password,
              obscureText: passwordInvisible,
              label: "PASSWORD",
              onChanged: (value) {
                password = value;
              },
              onSubmitted: (value) {
                whichTap = "";
              },
              onTap: () {
                whichTap = "password";
              },
              suffixIcon: GestureDetector(
                onTap: () {
                  setState(() {
                    passwordInvisible = !passwordInvisible;
                  });
                },
                child: Icon(
                  passwordInvisible ? Icons.visibility_off : Icons.visibility,
                  color: passwordInvisible
                      ? kFontColor.withOpacity(.5)
                      : kFontColor.withOpacity(.87),
                ),
              ),
            ),
            InputContainer(
              deco: whichTap == "confpass"
                  ? BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: kSecondaryColor.withAlpha(70))
                  : BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: kPrimaryColor),
              icon:
                  whichTap == "confpass" ? Icons.lock_open : Icons.lock_outline,
              obscureText: true,
              value: confpass,
              label: "CONFIRM PASSWORD",
              onChanged: (value) {
                confpass = value;
              },
              onSubmitted: (value) {
                whichTap = "";
              },
              onTap: () {
                whichTap = "confpass";
              },
            ),
            SizedBox(
              height: size.height * 0.1,
            ),
            MenuButton(
              title: "REGISTER",
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

                    await registeruser(credential, context).then((value) async {
                      if (value) {
                        await login(
                                {"email": email, "password": password}, context)
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
