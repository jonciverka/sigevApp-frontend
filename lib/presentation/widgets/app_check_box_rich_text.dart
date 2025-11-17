import 'package:flutter/material.dart';
import 'package:sigev/config/theme/app_theme.dart';

class AppCheckBoxRichText extends StatelessWidget {
  const AppCheckBoxRichText({
    super.key,
    this.value,
    required this.label,
    this.onChanged,
  });

  final bool? value;
  final void Function(bool?)? onChanged;
  final InlineSpan label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // For this checkbox there are three possible values: true, false, null
        // False, the checkbox is unchecked and null, the checkbox is indeterminate
        // The cycle goes false => true => null => false
        SizedBox(
          width: context.spacing32,
          height: context.spacing32,
          child: Checkbox(
            side: const BorderSide(
              color: AppTheme.neutralColorDarkGrey,
              width: 2,
            ),
            activeColor: AppTheme.primaryColor,
            checkColor: Colors.white,
            focusColor: AppTheme.neutralColorLightGrey,
            splashRadius: context.spacing16,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
            tristate: true,
            value: value,
            onChanged: onChanged,
          ),
        ),
        SizedBox(width: context.spacing4),
        Flexible(child: RichText(text: label)),
      ],
    );
  }
}
