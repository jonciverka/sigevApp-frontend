import 'package:flutter/material.dart';
import 'package:sigev/config/theme/app_icons.dart';
import 'package:sigev/config/theme/app_theme.dart';
import 'package:sigev/presentation/widgets/app_icon_buttons.dart';

class AppChip extends StatelessWidget {
  const AppChip({super.key, required this.label, this.onDeletePressed});

  final String label;
  final VoidCallback? onDeletePressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 36,
      padding: EdgeInsets.only(left: context.spacing12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        border: Border.all(
          color: onDeletePressed == null
              ? AppTheme.neutralColorLightGrey
              : AppTheme.neutralColorBlack,
          width: 2,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Flexible(
            child: Text(
              label,
              style: context.captionBoldTextStyle.copyWith(
                color: onDeletePressed == null
                    ? AppTheme.neutralColorLightGrey
                    : AppTheme.neutralColorBlack,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SizedBox(width: context.spacing4),
          SizedBox(
            height: 36,
            width: 36,
            child: AppSecondaryIconButton(
              icon: AppIcons.close,
              color: onDeletePressed == null
                  ? AppTheme.neutralColorLightGrey
                  : AppTheme.neutralColorBlack,
              iconSize: IconSize.small,
              onPressed: onDeletePressed,
            ),
          ),
        ],
      ),
    );
  }
}
