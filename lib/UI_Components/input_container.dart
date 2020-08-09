import 'package:flutter/material.dart';
import 'package:project_layout_1/components/configuration.dart';

class InputContainer extends StatelessWidget {
  const InputContainer({
    Key key,
    this.onTap,
    this.onSubmitted,
    this.value = "",
    this.onChanged,
    @required this.deco,
    this.label = "",
    this.icon,
    this.obscureText = false,
    this.suffixIcon,
  }) : super(key: key);

  final Function onTap;
  final Function onSubmitted;
  final String value;
  final Function onChanged;
  final BoxDecoration deco;
  final String label;
  final IconData icon;
  final Widget suffixIcon;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      margin: EdgeInsets.symmetric(horizontal: size.width * 0.07),
      decoration: deco,
      child: TextField(
        onTap: onTap,
        onSubmitted: onSubmitted,
        controller: TextEditingController(text: value),
        onChanged: onChanged,
        obscureText: obscureText,
        style: TextStyle(color: kFontColor, fontWeight: FontWeight.w500),
        decoration: InputDecoration(
            icon: Icon(
              icon,
              color: kFontColor.withOpacity(0.5),
            ),
            border: InputBorder.none,
            labelText: label,
            labelStyle: TextStyle(color: kFontColor.withOpacity(0.5)),
            suffixIcon: suffixIcon),
      ),
    );
  }
}
