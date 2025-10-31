import 'package:flutter/material.dart';
import 'package:sigev/config/theme/app_icons.dart';
import 'package:sigev/config/theme/app_theme.dart';
import 'package:sigev/presentation/widgets/app_buttons.dart';
import 'package:sigev/presentation/widgets/app_icon_buttons.dart';

Future<T?> showAppBottomSheetPregunta<T extends Object?>({
  required BuildContext context,
  required String title,
  required String question,
  required String yes,
  required Function() onYes,
}) =>
    showModalBottomSheet(
      context: context,
      isScrollControlled: false,
      useSafeArea: true,
      isDismissible: true,
      useRootNavigator: true,
      builder: (context) {
        return FractionallySizedBox(
          heightFactor: .65,
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(
              horizontal: context.spacing20,
              vertical: context.spacing20,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: context.headingLargeTextStyle,
                        overflow: TextOverflow.clip,
                      ),
                    ),
                    AppSecondaryIconButton(
                      icon: AppIcons.close,
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
                SizedBox(height: context.spacing12),
                AppBottomSheetPreguntaBody(question: question, yes: yes),
              ],
            ),
          ),
        );
      },
    ).then((value) async {
      if (value == true) onYes();
      return null;
    });

class AppBottomSheetPreguntaBody extends StatelessWidget {
  const AppBottomSheetPreguntaBody({
    super.key,
    required this.question,
    required this.yes,
  });
  final String question;
  final String yes;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          question,
          style: context.bodyRegularTextStyle,
          textAlign: TextAlign.center,
        ),
        SizedBox(height: context.spacing32),
        AppPrimaryButton(
          label: yes,
          onPressed: () => Navigator.pop(context, true),
        ),
        SizedBox(height: context.spacing12),
        AppSecondaryButton(
          label: "No",
          onPressed: () => Navigator.pop(context, false),
        ),
      ],
    );
  }
}
