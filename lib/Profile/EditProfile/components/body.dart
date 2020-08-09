import 'package:flutter/material.dart';
import 'package:project_layout_1/HttpController/http_request.dart';
import 'package:project_layout_1/UI_Components/input_container.dart';
import 'package:project_layout_1/components/configuration.dart';
import 'package:project_layout_1/components/loading_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  String whichTap = "";

  @override
  void initState() {
    super.initState();
    callAPI();
  }

  Future<dynamic> callAPI() async {
    SharedPreferences shared = await SharedPreferences.getInstance();
    var data = await authorizedgetrequest(
        "user/getuserdetail?t=${shared.getString('token')}", context);

    return data;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return FutureBuilder(
        future: callAPI(),
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return LoadingScreen();
          else
            return SingleChildScrollView(
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
                          "Edit Biodata",
                          style: Theme.of(context).textTheme.headline1,
                        ),
                        Text("\t\t"),
                      ],
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
                          ),
                    onTap: () {
                      setState(() {
                        whichTap = "fullname";
                      });
                    },
                    onChanged: (value) {},
                    onSubmitted: (value) {
                      setState(() {
                        whichTap = "";
                      });
                    },
                    label: "FULL NAME",
                    icon: Icons.person_outline,
                    value: snapshot.data['fullname'],
                  ),
                ],
              ),
            );
        });
  }
}
