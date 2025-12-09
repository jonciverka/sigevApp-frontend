import 'package:flutter/material.dart';
import 'package:sigev/config/theme/app_icons.dart';
import 'package:sigev/config/theme/app_theme.dart';
import 'package:sigev/presentation/widgets/app_icon_buttons.dart';

Future<T?> showAppBottomSheet<T extends Object?>({
  required BuildContext context,
  required Widget child,
  required String title,
  bool useRootNavigator = true,
  double heightFactor = .9,
  bool isScrollControlled = true,
  bool useSafeArea = true,
  bool isDismissible = true,
  bool enableDrag = true,
}) => showModalBottomSheet(
  context: context,
  isScrollControlled: isScrollControlled,
  useSafeArea: useSafeArea,
  isDismissible: isDismissible,
  useRootNavigator: useRootNavigator,
  enableDrag: enableDrag,
  builder: (context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: FractionallySizedBox(
        heightFactor: heightFactor == 0 ? null : heightFactor,
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
                  Expanded(
                    child: Text(
                      title,
                      style: context.headingLargeTextStyle,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
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
      ),
    );
  },
);
