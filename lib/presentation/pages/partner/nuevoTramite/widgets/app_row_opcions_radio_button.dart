import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:sigev/config/theme/app_theme.dart';
import 'package:sigev/core/constant/strings.dart';
import 'package:sigev/presentation/widgets/app_radio_button.dart';

class AppRowOpcionsRadioButton extends StatelessWidget {
  const AppRowOpcionsRadioButton({
    super.key,
    required this.groupValue,
    required this.label,
    required this.child,
    required this.onChanged,
  });
  final String groupValue;
  final String label;
  final Widget child;
  final Function(String?) onChanged;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(label, style: context.bodyRegularTextStyle),
        SizedBox(height: context.spacing12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            AppRadioButton<String>(
              label: AppLocale.textRadioAplica.getString(context),
              value: "1",
              groupValue: groupValue,
              onChanged: onChanged,
            ),
            AppRadioButton<String>(
              label: AppLocale.textRadionoAplica.getString(context),
              value: "2",
              groupValue: groupValue,
              onChanged: onChanged,
            ),
          ],
        ),
        child,
      ],
    );
  }
}
