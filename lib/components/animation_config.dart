import 'package:flutter/material.dart';

final Duration duration = const Duration(milliseconds: 300);
AnimationController animateController;
Animation<double> scaleAnimation;
Animation<double> menuScaleAnimation;
Animation<Offset> slideAnimation;
bool isCollapsed = true;
