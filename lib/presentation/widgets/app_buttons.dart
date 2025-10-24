import 'package:flutter/material.dart';
import 'package:sigev/config/theme/app_icons.dart';
import 'package:sigev/config/theme/app_theme.dart';

class AppPrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final double? width;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final bool isIconCentered;
  final bool overflowText;

  const AppPrimaryButton({
    super.key,
    required this.label,
    this.onPressed,
    this.width,
    this.isIconCentered = true,
    this.overflowText = false,
    this.prefixIcon,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        minWidth: context.spacing64,
        maxWidth: double.infinity,
        maxHeight: context.spacing40,
        minHeight: context.spacing40,
      ),
      child: SizedBox(
        width: (width == null)
            ? double.infinity
            : (width?.isNaN ?? false)
            ? null
            : width!,
        child: FilledButton(
          style: AppTheme.primaryFilledButtonStyle(context),
          onPressed: onPressed,
          child: prefixIcon != null
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppIcons.smallIcon(prefixIcon!),
                    isIconCentered
                        ? SizedBox(width: context.spacing8)
                        : const Spacer(),
                    Text(label, style: AppTheme.buttonTextStyle(context)),
                    if (!isIconCentered) const Spacer(),
                  ],
                )
              : suffixIcon != null
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (isIconCentered) const Spacer(),
                    Text(label, style: AppTheme.buttonTextStyle(context)),
                    isIconCentered
                        ? const Spacer()
                        : SizedBox(width: context.spacing8),
                    AppIcons.smallIcon(suffixIcon!),
                  ],
                )
              : Text(
                  label,
                  textAlign: TextAlign.center,
                  style: AppTheme.buttonTextStyle(context),
                  overflow: overflowText ? TextOverflow.ellipsis : null,
                  maxLines: overflowText ? 1 : null,
                ),
        ),
      ),
    );
  }
}

class AppSecondaryButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final double? width;
  final IconData? prefixIcon;
  final bool isIconCentered;

  const AppSecondaryButton({
    super.key,
    required this.label,
    this.onPressed,
    this.width,
    this.prefixIcon,
    this.isIconCentered = true,
  });

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        minWidth: context.spacing64,
        maxHeight: context.spacing40,
        minHeight: context.spacing40,
      ),
      child: SizedBox(
        width: (width == null)
            ? double.infinity
            : (width?.isNaN ?? false)
            ? null
            : width!,
        child: FilledButton(
          style: AppTheme.secondaryFilledButtonStyle(context),
          onPressed: onPressed,
          child: prefixIcon != null
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppIcons.smallIcon(prefixIcon!),
                    isIconCentered
                        ? SizedBox(width: context.spacing8)
                        : const Spacer(),
                    SizedBox(
                      child: Text(
                        label,
                        style: AppTheme.buttonTextStyle(context),
                      ),
                    ),
                    if (!isIconCentered) const Spacer(),
                  ],
                )
              : Text(
                  label,
                  textAlign: TextAlign.center,
                  style: AppTheme.buttonTextStyle(context),
                ),
        ),
      ),
    );
  }
}

class AppTertiaryButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final double? width;
  final IconData? suffixIcon;
  final IconData? prefixIcon;
  final bool withConstraintHeight;
  final bool isSelected;

  const AppTertiaryButton({
    super.key,
    required this.label,
    this.onPressed,
    this.width,
    this.suffixIcon,
    this.prefixIcon,
    this.withConstraintHeight = true,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        minWidth: context.spacing64,
        maxHeight: context.spacing40,
        minHeight: withConstraintHeight ? context.spacing40 : 0.0,
      ),
      child: SizedBox(
        width: (width == null)
            ? double.infinity
            : (width?.isNaN ?? false)
            ? null
            : width!,
        child: FilledButton(
          style: AppTheme.tertiaryButtonStyle(
            context,
            isSelected: isSelected,
            withFixedHeight: withConstraintHeight,
          ),
          onPressed: onPressed,
          child: suffixIcon != null
              ? Row(
                  children: [
                    AppIcons.smallIcon(suffixIcon!),
                    SizedBox(width: context.spacing8),
                    SizedBox(
                      child: Text(
                        label,
                        style: AppTheme.buttonTextStyle(context),
                      ),
                    ),
                  ],
                )
              : prefixIcon != null
              ? Row(
                  children: [
                    SizedBox(
                      child: Text(
                        label,
                        style: AppTheme.buttonTextStyle(context),
                      ),
                    ),
                    SizedBox(width: context.spacing8),
                    AppIcons.smallIcon(prefixIcon!),
                  ],
                )
              : Text(
                  label,
                  textAlign: TextAlign.center,
                  style: AppTheme.buttonTextStyle(context),
                ),
        ),
      ),
    );
  }
}
