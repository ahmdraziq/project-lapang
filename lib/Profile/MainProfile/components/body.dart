import 'package:flutter/material.dart';
import 'package:project_layout_1/Profile/EditProfile/editprofile_screen.dart';
import 'package:project_layout_1/components/configuration.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Image.asset(
            "assets/images/profile.jpg",
            width: size.width,
            fit: BoxFit.fill,
          ),
          Container(
            width: size.width,
            height: size.height,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(size.width * 0.07,
                      size.height * 0.08, size.width * 0.07, 0.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                      Text(
                        "Your Profile",
                        style: Theme.of(context).textTheme.headline1,
                      ),
                      Text("\t\t"),
                    ],
                  ),
                ),
                SizedBox(
                  height: size.height * 0.05,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) {
                        return EditProfileScreen();
                      },
                    ));
                  },
                  child: Container(
                    width: size.width * 0.9,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(29)),
                    padding: EdgeInsets.symmetric(
                        horizontal: size.width * 0.1,
                        vertical: size.height * 0.02),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          "Edit Information",
                          style: TextStyle(color: kFontColor, fontSize: 18),
                        ),
                        Icon(
                          Icons.chevron_right,
                          color: kFontColor,
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: size.width * 0.07),
                  child: Divider(
                    color: kFontColor,
                  ),
                ),
                Container(
                  width: size.width * 0.9,
                  padding: EdgeInsets.symmetric(
                      horizontal: size.width * 0.1,
                      vertical: size.height * 0.02),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "To be fikirkan",
                        style: TextStyle(color: kFontColor, fontSize: 18),
                      ),
                      Icon(
                        Icons.chevron_right,
                        color: kFontColor,
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: size.width * 0.07),
                  child: Divider(
                    color: kFontColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
