import 'package:flutter/material.dart';
import 'package:project_layout_1/components/configuration.dart';

class LoadingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(kOnPrimaryColor),
        ),
      ),
    );
  }
}
