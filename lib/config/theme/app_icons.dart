import 'package:flutter/material.dart';
import 'package:sigev/config/theme/icons_own_icons.dart';

class AppIcons {
  // Icons color
  static const Color iconColor = Colors.black;

  // Icons sizes
  static const double iconSmallSize = 16.0;
  static const double iconMediumSize = 24.0;
  static const double iconLargeSize = 32.0;
  static const double iconXLargeSize = 64.0;
  //Menu icons
  static const IconData add = IconsOwn.add;
  static const IconData orderSave = IconsOwn.ordersave;
  static const IconData person = IconsOwn.person;
  static const IconData home = IconsOwn.home;
  //Navigation
  static const IconData arrowBack = IconsOwn.arrow_back;
  static const IconData arrowDown = IconsOwn.arrow_downward;
  static const IconData arrowForward = IconsOwn.arrow_forward;
  static const IconData arrowUp = IconsOwn.arrow_upward;
  //Action
  static const IconData close = IconsOwn.close;
  static const IconData delete = IconsOwn.delete;
  static const IconData logout = IconsOwn.logout;
  static const IconData refresh = IconsOwn.loop_alt;
  //Others
  static const IconData addCircle = IconsOwn.addcircle;
  static const IconData password = IconsOwn.ordersavedpass;
  static const IconData search = IconsOwn.search;
  static const IconData warning = IconsOwn.warning;
  static const IconData error = IconsOwn.error;
  static const IconData train = IconsOwn.train;
  static const IconData car = IconsOwn.car;
  static const IconData bus = IconsOwn.bus;
  static const IconData calendar = IconsOwn.calendar_empty;
  static const IconData arrowLogo = IconsOwn.arrow;
  static const IconData checkCircle = Icons.check_circle;
  // Icons
  static Icon smallIcon(IconData icon, {Color? color}) =>
      Icon(icon, size: iconSmallSize, color: color);
  static Icon mediumIcon(IconData icon, {Color? color}) =>
      Icon(icon, size: iconMediumSize, color: color);
  static Icon largeIcon(IconData icon, {Color? color}) =>
      Icon(icon, size: iconLargeSize, color: color);
  static Icon xLargeIcon(IconData icon, {Color? color}) =>
      Icon(icon, size: iconXLargeSize, color: color);
}
