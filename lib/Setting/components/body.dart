import 'package:flutter/material.dart';
import 'package:project_layout_1/components/animation_config.dart';
import 'package:project_layout_1/components/configuration.dart';

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
                        Text(
                          "Setting",
                          style: Theme.of(context).textTheme.headline1,
                        ),
                        Text("\t\t"),
                      ],
                    ),
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
