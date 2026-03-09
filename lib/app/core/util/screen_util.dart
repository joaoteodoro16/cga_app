import 'package:flutter/material.dart';

class ScreenUtils {
  ScreenUtils._();

  static Size size(BuildContext context) =>
      MediaQuery.sizeOf(context);

  static double width(BuildContext context) =>
      MediaQuery.sizeOf(context).width;

  static double height(BuildContext context) =>
      MediaQuery.sizeOf(context).height;

  static EdgeInsets padding(BuildContext context) =>
      MediaQuery.paddingOf(context);

  static bool isMobile(BuildContext context) =>
      width(context) < 600;

  static bool isTablet(BuildContext context) =>
      width(context) >= 600 && width(context) < 1024;

  static bool isDesktop(BuildContext context) =>
      width(context) >= 1024;
}