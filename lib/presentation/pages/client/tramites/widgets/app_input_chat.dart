import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:sigev/config/theme/app_icons.dart';
import 'package:sigev/config/theme/app_theme.dart';
import 'package:sigev/core/constant/strings.dart';
import 'package:sigev/presentation/widgets/app_icon_buttons.dart';
import 'package:sigev/presentation/widgets/app_inputs.dart';

class AppInputChat<T> extends StatefulWidget {
  final Function onSubmit;
  final TextEditingController _textController;

  const AppInputChat({
    super.key,
    required this.onSubmit,
    required TextEditingController textController,
  }) : _textController = textController;

  @override
  State<AppInputChat<T>> createState() => _AppInputChatState<T>();
}

class _AppInputChatState<T> extends State<AppInputChat<T>> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: AppTextFormFieldChat(
            maxLines: 3,
            controller: widget._textController,
            labelText: AppLocale.inputChat.getString(context),
            hintText: AppLocale.inputChat.getString(context),
            validator: (value) {
              return null;
            },
            onChanged: (_) => setState(() {}),
            onSubmitted: (_) => widget.onSubmit(),
            onIconButtonPressed: widget._textController.text.isNotEmpty
                ? null
                : null,
          ),
        ),
        if (widget._textController.text.isNotEmpty)
          SizedBox(width: context.spacing4),
        if (widget._textController.text.isNotEmpty)
          AppIconButton(
            icon: AppIcons.arrowLogo,
            onPressed: () => widget.onSubmit(),
            iconSize: IconSize.medium,
          ),
      ],
    );
  }
}
