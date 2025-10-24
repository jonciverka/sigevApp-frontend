import 'package:flutter/material.dart';
import 'package:sigev/config/theme/app_icons.dart';
import 'package:sigev/config/theme/app_theme.dart';

enum IconSize { small, medium, large }

class AppIconButton extends StatelessWidget {
  const AppIconButton({
    super.key,
    required this.icon,
    this.onPressed,
    this.iconSize = IconSize.medium,
    this.badgeCount = 0,
    this.color,
  });

  final IconData icon;
  final VoidCallback? onPressed;
  final IconSize iconSize;
  final int badgeCount;

  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        // IconButton
        IconButton(
          style: AppTheme.primaryIconButtonStyle(context),
          icon: switch (iconSize) {
            IconSize.small => AppIcons.smallIcon(icon),
            IconSize.medium => AppIcons.mediumIcon(icon),
            IconSize.large => AppIcons.largeIcon(icon),
          },
          color: AppTheme.neutralColorWhite,
          onPressed: onPressed,
        ),
      ],
    );
  }
}

class AppSecondaryIconButton extends StatelessWidget {
  const AppSecondaryIconButton({
    super.key,
    required this.icon,
    this.onPressed,
    this.iconSize = IconSize.medium,
    this.badgeCount = 0,
    this.active = false,
    this.color,
  });

  final IconData icon;
  final VoidCallback? onPressed;
  final IconSize iconSize;
  final int badgeCount;
  final Color? color;
  final bool active;
  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        // IconButton
        IconButton(
          padding: EdgeInsets.zero,
          style: active
              ? AppTheme.secondaryIconButtonStyleWithBadge(context)
              : AppTheme.secondaryIconButtonStyle(context),
          icon: switch (iconSize) {
            IconSize.small => AppIcons.smallIcon(icon, color: color),
            IconSize.medium => AppIcons.mediumIcon(icon, color: color),
            IconSize.large => AppIcons.largeIcon(icon, color: color),
          },
          color: color,
          onPressed: onPressed,
        ),

        // Badge
        if (badgeCount > 0)
          Positioned(
            top: context.spacing2,
            left: 30,
            child: Align(
              alignment: Alignment.topRight,
              child: Container(
                padding: badgeCount < 10
                    ? EdgeInsets.zero
                    : EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: context.spacing2,
                      ),
                decoration: BoxDecoration(
                  color: AppTheme.primaryColor,
                  shape: badgeCount < 10 ? BoxShape.circle : BoxShape.rectangle,
                  borderRadius: badgeCount < 10
                      ? null
                      : BorderRadius.circular(100),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                constraints: BoxConstraints(
                  minWidth: context.spacing16,
                  minHeight: context.spacing16,
                ),
                alignment: Alignment.center,
                clipBehavior: Clip.hardEdge,
                child: Text(
                  badgeCount.toString(),
                  style: AppTheme.captionBold(
                    context,
                  ).copyWith(color: AppTheme.neutralColorWhite, fontSize: 12),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class AppMenuIconButton extends StatelessWidget {
  const AppMenuIconButton({
    super.key,
    required this.icon,
    this.onPressed,
    this.iconSize = IconSize.medium,
    this.badgeCount = 0,
    this.active = false,
    this.color,
    required this.title,
  });

  final IconData icon;
  final VoidCallback? onPressed;
  final IconSize iconSize;
  final int badgeCount;
  final Color? color;
  final bool active;
  final String title;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onPressed?.call(),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(icon, color: active ? AppTheme.primaryColor : null),
            Text(
              title,
              style: active
                  ? context.captionBoldTextStyle.copyWith(
                      color: active ? AppTheme.primaryColor : null,
                    )
                  : context.captionRegularTextStyle.copyWith(
                      color: active ? AppTheme.primaryColor : null,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class AppIconButtonWhatsapp extends StatelessWidget {
  const AppIconButtonWhatsapp({
    super.key,
    required this.icon,
    this.onPressed,
    this.iconSize = IconSize.medium,
    this.badgeCount = 0,
    this.color,
  });

  final IconData icon;
  final VoidCallback? onPressed;
  final IconSize iconSize;
  final int badgeCount;

  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        // IconButton
        IconButton(
          style: AppTheme.primaryIconButtonStyleWhats(context),
          icon: switch (iconSize) {
            IconSize.small => AppIcons.smallIcon(icon),
            IconSize.medium => AppIcons.mediumIcon(icon),
            IconSize.large => AppIcons.largeIcon(icon),
          },
          color: AppTheme.neutralColorWhite,
          onPressed: onPressed,
        ),
      ],
    );
  }
}
