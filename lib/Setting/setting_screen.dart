import 'package:flutter/material.dart';
import 'package:project_layout_1/components/animation_config.dart';
import 'package:project_layout_1/components/configuration.dart';

class SettingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Body();
  }
}

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
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
          child: SingleChildScrollView(
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
                        "Setting",
                        style: Theme.of(context).textTheme.headline1,
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
