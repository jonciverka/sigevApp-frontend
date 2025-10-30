import 'package:flutter/material.dart';
import 'package:sigev/config/theme/app_icons.dart';
import 'package:sigev/config/theme/app_theme.dart';
import 'package:sigev/presentation/widgets/app_icon_buttons.dart';

Future<T?> showAppBottomSheet<T extends Object?>({
  required BuildContext context,
  required Widget child,
  required String title,
}) => showModalBottomSheet(
  context: context,
  isScrollControlled: true,
  useSafeArea: true,
  isDismissible: true,
  useRootNavigator: true,
  builder: (context) {
    return FractionallySizedBox(
      heightFactor: .9,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          horizontal: context.spacing16,
          vertical: context.spacing20,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title, style: context.headingLargeTextStyle),
                AppSecondaryIconButton(
                  icon: AppIcons.close,
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            child,
          ],
        ),
      ),
    );
  },
);
