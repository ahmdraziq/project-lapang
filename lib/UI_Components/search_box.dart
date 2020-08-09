import 'package:flutter/material.dart';
import 'package:project_layout_1/components/configuration.dart';

class SearchBox extends StatelessWidget {
  final ValueChanged<String> onChanged;
  final bool disabled;

  const SearchBox({Key key, this.onChanged, this.disabled = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding:
          EdgeInsets.fromLTRB(size.width * 0.07, 0.0, size.width * 0.07, 0.0),
      child: Container(
        padding: EdgeInsets.fromLTRB(10, 5, 30, 5),
        width: size.width * 0.9,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: kPrimaryColor,
            boxShadow: [
              BoxShadow(
                  offset: Offset(1.0, 0.0),
                  color: kSecondaryColor,
                  blurRadius: 6.0),
            ]),
        child: TextField(
          readOnly: disabled,
          onChanged: onChanged,
          decoration: InputDecoration(
              border: InputBorder.none,
              icon: Icon(
                Icons.search,
                color: kFontColor,
              ),
              hintText: "Search for something...",
              hintStyle: TextStyle(color: kFontColor.withOpacity(.5))),
        ),
      ),
    );
  }
}
