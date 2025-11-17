import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sigev/config/theme/app_theme.dart';

/// [STANDARD TEXTFIELD]

class AppTextField extends StatefulWidget {
  final double? width;
  final TextEditingController? controller;
  final bool enabled;
  final bool obscureText;
  final String? labelText;
  final String? hintText;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final int maxLines;
  final int minLines;
  final TextAlign textAlign;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final void Function(String) onChanged;
  final void Function(String)? onSubmitted;
  final VoidCallback? onIconButtonPressed;
  final bool hasError;

  final bool readOnly;

  const AppTextField({
    super.key,
    required this.onChanged,
    this.onSubmitted,
    this.width,
    this.controller,
    this.keyboardType,
    this.labelText,
    this.hintText,
    this.onIconButtonPressed,
    this.prefixIcon,
    this.suffixIcon,
    this.inputFormatters,
    this.obscureText = false,
    this.enabled = true,
    this.maxLines = 1,
    this.minLines = 1,
    this.readOnly = false,
    this.textAlign = TextAlign.start,
    this.hasError = false,
  });

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  late FocusNode _focusNode;
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _controller = widget.controller ?? TextEditingController();

    _focusNode.addListener(() => setState(() {}));
    _controller.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isFocused = _focusNode.hasFocus;
    final bool hasText = _controller.text.isNotEmpty;
    final bool hasError = widget.hasError;

    // Color del borde según el estado
    Color borderColor;
    if (hasError) {
      borderColor = Colors.red;
    } else if (isFocused || hasText) {
      borderColor = Colors.transparent;
    } else {
      borderColor = Colors.transparent;
    }
    return Container(
      width: widget.width ?? double.infinity,
      padding: EdgeInsets.only(
        left: context.spacing16,
        right: context.spacing16,
        top: isFocused || hasText ? context.spacing16 : context.spacing12,
        bottom: isFocused || hasText ? context.spacing12 : context.spacing16,
      ),
      decoration: BoxDecoration(
        color: AppTheme.neutralColorWhite,
        border: Border.all(color: borderColor, width: 2),
        borderRadius: BorderRadius.circular(context.spacing8),
      ),
      child: Row(
        children: [
          if (widget.prefixIcon != null)
            Padding(
              padding: EdgeInsets.only(right: context.spacing12),
              child: Icon(widget.prefixIcon, color: Colors.red),
            ),
          Expanded(
            child: TextField(
              decoration: _buildDecoration(),
              maxLines: widget.maxLines,
              minLines: widget.minLines,
              obscureText: widget.obscureText,
              textAlign: widget.textAlign,
              controller: widget.controller,
              readOnly: widget.readOnly,
              focusNode: _focusNode,
              keyboardType: widget.keyboardType,
              inputFormatters: widget.inputFormatters,
              enabled: widget.enabled,
              style: context.bodyRegularTextStyle,
              onChanged: widget.onChanged,
              onSubmitted: widget.onSubmitted,
            ),
          ),
          if (widget.suffixIcon != null)
            Padding(
              padding: EdgeInsets.only(right: context.spacing12),
              child: Icon(widget.suffixIcon, color: Colors.red),
            ),
        ],
      ),
    );
  }

  InputDecoration _buildDecoration() => AppTheme.textFieldDecoration(
    context,
    labelText: widget.labelText,
    showFocusedBorder: true,
    onIconButtonPressed: widget.onIconButtonPressed,
    hintText: widget.hintText,
    isEnabled: widget.enabled,
    showBorder: false,
    smallBorderRadius: widget.maxLines > 1,
  );
}

/// [FORM TEXTFIELD]

class AppTextFormField extends StatefulWidget {
  final double? width;
  final TextEditingController? controller;
  final bool enabled;
  final bool obscureText;
  final String? initialValue;
  final String? labelText;
  final String? hintText;

  final TextAlign textAlign;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final int maxLines;
  final int minLines;
  final int? maxLength;
  final int? maxLengthFormatter;
  final IconData? suffixIcon;

  final void Function(String) onChanged;
  final void Function(String?)? onSubmitted;
  final void Function(String?)? onSaved;
  final FormFieldValidator<String>? validator;
  final VoidCallback? onIconButtonPressed;

  final IconData? prefixIcon;
  final bool readOnly;
  final VoidCallback? onTap;

  const AppTextFormField({
    super.key,
    required this.onChanged,
    required this.validator,
    this.onSubmitted,
    this.onSaved,
    this.suffixIcon,
    this.width,
    this.controller,
    this.inputFormatters,
    this.keyboardType,
    this.enabled = true,
    this.readOnly = false,
    this.labelText,
    this.hintText,
    this.prefixIcon,
    this.initialValue,
    this.onIconButtonPressed,
    this.obscureText = false,
    this.maxLines = 1,
    this.minLines = 1,
    this.maxLength,
    this.maxLengthFormatter,
    this.textAlign = TextAlign.start,
    this.onTap,
  });

  @override
  State<AppTextFormField> createState() => _AppTextFormFieldState();
}

class _AppTextFormFieldState extends State<AppTextFormField> {
  late FocusNode _focusNode;
  late TextEditingController _controller;
  bool hasError = false;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _controller = widget.controller ?? TextEditingController();
    _focusNode.addListener(() => setState(() {}));
    _controller.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isFocused = _focusNode.hasFocus;
    final bool hasText = _controller.text.isNotEmpty;
    final bool active = isFocused || hasText;
    final bool hasError = errorMessage.isNotEmpty;

    // Color del borde según el estado
    Color borderColor;
    if (hasError) {
      borderColor = Colors.red;
    } else if (isFocused || hasText) {
      borderColor = Colors.transparent;
    } else {
      borderColor = Colors.transparent;
    }
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: widget.width ?? double.infinity,
          padding: EdgeInsets.only(
            left: context.spacing16,
            right: context.spacing16,
            top: active ? 14 : context.spacing12,
            bottom: active ? context.spacing12 : 14,
          ),
          decoration: BoxDecoration(
            boxShadow: AppTheme.smallElevationShadow,
            color: !widget.enabled
                ? AppTheme.neutralColorLightGrey
                : AppTheme.neutralColorBg,
            border: Border.all(color: borderColor, width: 2),
            borderRadius: BorderRadius.circular(context.spacing12),
          ),
          child: Row(
            children: [
              if (widget.prefixIcon != null)
                Padding(
                  padding: EdgeInsets.only(right: 7),
                  child: Icon(
                    widget.prefixIcon,
                    color: !widget.enabled
                        ? AppTheme.neutralColorDarkGrey
                        : AppTheme.neutralColorBlack,
                  ),
                ),
              Expanded(
                child: TextFormField(
                  decoration: _buildDecoration(),
                  initialValue: widget.initialValue,
                  obscureText: widget.obscureText,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(widget.maxLengthFormatter),
                    ...widget.inputFormatters ?? [],
                  ],
                  textInputAction: TextInputAction.next,
                  readOnly: widget.readOnly,
                  textAlign: widget.textAlign,
                  controller: widget.controller,
                  focusNode: _focusNode,
                  keyboardType: widget.keyboardType,
                  enabled: widget.enabled,
                  style: context.bodyRegularInputStyle,
                  maxLines: widget.maxLines,
                  onTap: widget.onTap,
                  minLines: widget.minLines,
                  maxLength: widget.maxLength,
                  onChanged: widget.onChanged,
                  onFieldSubmitted: widget.onSubmitted,
                  onSaved: widget.onSaved,
                  validator: (value) {
                    final result = widget.validator?.call(value);
                    if (result == null || result.isEmpty) return null;
                    setState(() {
                      errorMessage = result;
                    });

                    return errorMessage;
                  },
                ),
              ),
              if (widget.suffixIcon != null)
                Padding(
                  padding: EdgeInsets.only(right: context.spacing12),
                  child: Icon(widget.suffixIcon, color: Colors.red),
                ),
            ],
          ),
        ),
        if (hasError)
          Padding(
            padding: EdgeInsets.only(
              left: context.spacing8,
              top: context.spacing4,
            ),
            child: Text(
              errorMessage,
              style: context.errorTextstStyle,
              textAlign: TextAlign.start,
            ),
          ),
      ],
    );
  }

  InputDecoration _buildDecoration() => AppTheme.textFieldDecoration(
    context,
    labelText: widget.labelText,
    showFocusedBorder: true,
    onIconButtonPressed: widget.onIconButtonPressed,
    hintText: widget.hintText,
    isEnabled: widget.enabled,
    showBorder: false,
    smallBorderRadius: widget.maxLines > 1,
  );
}
