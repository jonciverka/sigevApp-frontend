import 'package:flutter/material.dart';

class AppIcons {
  // Icons color
  static const Color iconColor = Colors.black;

  // Icons sizes
  static const double iconSmallSize = 16.0;
  static const double iconMediumSize = 24.0;
  static const double iconLargeSize = 32.0;
  static const double iconXLargeSize = 64.0;
  static const IconData error = Icons.error_outline_rounded;
  static const IconData warning = Icons.warning_amber_rounded;
  static const IconData info = Icons.info_outline_rounded;
  static const IconData visibilityOff = Icons.visibility_off_rounded;
  static const IconData visibility = Icons.visibility_rounded;
  static const IconData notifications = Icons.notifications;

  // Actions Icons
  static const IconData addIcon = Icons.add_rounded;
  static const IconData close = Icons.close_rounded;
  static const IconData keyBoardArrowDown = Icons.keyboard_arrow_down_rounded;
  static const IconData checkCircle = Icons.check_circle_outline_rounded;
  static const IconData logout = Icons.logout;
  static const IconData delete = Icons.delete;

  // Navigation Icons
  static const IconData search = Icons.search;
  static const IconData clean = Icons.cleaning_services_outlined;
  static const IconData arrowBack = Icons.arrow_back;
  static const IconData arrowDownward = Icons.arrow_downward;
  static const IconData arrowForward = Icons.arrow_forward;
  static const IconData arrowUpward = Icons.arrow_upward;
  static const IconData chevronLeft = Icons.chevron_left_rounded;
  static const IconData chevronRight = Icons.chevron_right_rounded;
  static const IconData keyBoardArrowUp = Icons.keyboard_arrow_up_rounded;
  //Others
  static const IconData calendar = Icons.calendar_month;
  static const IconData refresh = Icons.refresh;

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
