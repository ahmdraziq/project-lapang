import 'package:flutter/material.dart';
import 'package:project_layout_1/components/configuration.dart';

class MenuButton extends StatelessWidget {
  const MenuButton({
    Key key,
    this.title = "Insert Title",
    this.onPressed,
  }) : super(key: key);

  final String title;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ClipRRect(
      borderRadius: BorderRadius.circular(50),
      child: Container(
        width: size.width * 0.6,
        decoration: BoxDecoration(color: kAccentColor),
        child: FlatButton(
          onPressed: onPressed,
          padding: EdgeInsets.all(15),
          child: Text(title),
        ),
      ),
    );
  }
}
