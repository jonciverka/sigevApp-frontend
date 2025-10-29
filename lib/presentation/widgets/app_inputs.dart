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
  final IconData? suffixIcon;
  final IconData? prefixIcon;
  final int maxLines;
  final int minLines;
  final TextAlign textAlign;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final void Function(String) onChanged;
  final void Function(String)? onSubmitted;
  final VoidCallback? onIconButtonPressed;

  const AppTextField({
    super.key,
    required this.onChanged,
    this.onSubmitted,
    this.width,
    this.controller,
    this.keyboardType,
    this.labelText,
    this.hintText,
    this.suffixIcon,
    this.onIconButtonPressed,
    this.prefixIcon,
    this.inputFormatters,
    this.obscureText = false,
    this.enabled = true,
    this.maxLines = 1,
    this.minLines = 1,
    this.textAlign = TextAlign.start,
  });

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  late final FocusNode _keyboardListenerFocusNode;
  late final FocusNode _textFieldFocusNode;
  late bool hasFocus;
  late bool isFocusedWithKeyboard;

  @override
  void initState() {
    _keyboardListenerFocusNode = FocusNode();
    _textFieldFocusNode = FocusNode();
    _textFieldFocusNode.addListener(_onFocusChange);
    _keyboardListenerFocusNode.addListener(_onFocusChange);
    hasFocus = false;
    isFocusedWithKeyboard = false;
    super.initState();
  }

  @override
  void dispose() {
    _keyboardListenerFocusNode.dispose();
    _textFieldFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width ?? double.infinity,
      child: KeyboardListener(
        focusNode: _keyboardListenerFocusNode,
        onKeyEvent: (KeyEvent event) {
          if (event is KeyDownEvent &&
              event.logicalKey == LogicalKeyboardKey.tab) {
            isFocusedWithKeyboard = true;
          }
        },
        child: TextField(
          decoration: _buildDecoration(),
          maxLines: widget.maxLines,
          minLines: widget.minLines,
          obscureText: widget.obscureText,
          textAlign: widget.textAlign,
          controller: widget.controller,
          focusNode: _textFieldFocusNode,
          keyboardType: widget.keyboardType,
          inputFormatters: widget.inputFormatters,
          enabled: widget.enabled,
          style: context.bodyRegularTextStyle,
          onChanged: widget.onChanged,
          onSubmitted: widget.onSubmitted,
        ),
      ),
    );
  }

  void _onFocusChange() {
    setState(() {
      hasFocus = _keyboardListenerFocusNode.hasFocus;
      if (!_keyboardListenerFocusNode.hasFocus) {
        isFocusedWithKeyboard = false;
      }
    });
  }

  InputDecoration _buildDecoration() => AppTheme.textFieldDecoration(
    context,
    labelText: widget.labelText,
    showFocusedBorder: hasFocus && isFocusedWithKeyboard,
    onIconButtonPressed: widget.onIconButtonPressed,
    hintText: widget.hintText,
    suffixIcon: widget.suffixIcon,
    prefixIcon: widget.prefixIcon,
    isEnabled: widget.enabled,
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
  final String? errorText;
  final IconData? suffixIcon;
  final bool readOnly;
  final TextAlign textAlign;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final int maxLines;
  final int minLines;
  final int? maxLength;
  final int? maxLengthFormatter;
  final VoidCallback? onTap;
  final void Function(String) onChanged;
  final void Function(String?)? onSubmitted;
  final void Function(String?)? onSaved;
  final FormFieldValidator<String>? validator;
  final VoidCallback? onIconButtonPressed;

  const AppTextFormField({
    super.key,
    required this.onChanged,
    required this.validator,
    this.onSubmitted,
    this.onSaved,
    this.width,
    this.controller,
    this.inputFormatters,
    this.keyboardType,
    this.enabled = true,
    this.labelText,
    this.hintText,
    this.errorText,
    this.suffixIcon,
    this.initialValue,
    this.onIconButtonPressed,
    this.obscureText = false,
    this.maxLines = 1,
    this.minLines = 1,
    this.maxLength,
    this.maxLengthFormatter,
    this.textAlign = TextAlign.start,
    this.onTap,
    this.readOnly = false,
  });

  @override
  State<AppTextFormField> createState() => _AppTextFormFieldState();
}

class _AppTextFormFieldState extends State<AppTextFormField> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width ?? double.infinity,
      child: TextFormField(
        initialValue: widget.initialValue,
        textAlignVertical: TextAlignVertical.top,
        decoration: _buildDecoration(),
        obscureText: widget.obscureText,
        inputFormatters: [
          LengthLimitingTextInputFormatter(widget.maxLengthFormatter ?? 30),
          ...?widget.inputFormatters,
        ],
        textInputAction: TextInputAction.next,
        textAlign: widget.textAlign,
        controller: widget.controller,
        keyboardType: widget.keyboardType,
        enabled: widget.enabled,
        style: context.bodyRegularInputStyle,
        maxLines: widget.maxLines,
        minLines: widget.minLines,
        maxLength: widget.maxLength,
        onChanged: widget.onChanged,
        onFieldSubmitted: widget.onSubmitted,
        onSaved: widget.onSaved,
        validator: widget.validator,
        readOnly: widget.readOnly,
        onTap: widget.onTap,
        autovalidateMode: AutovalidateMode.onUserInteraction,
      ),
    );
  }

  InputDecoration _buildDecoration() => AppTheme.textFieldDecoration(
    context,
    labelText: widget.hintText,
    hintText: widget.hintText,
    suffixIcon: widget.suffixIcon,
    errorText: widget.errorText,
    isEnabled: widget.enabled,
    onIconButtonPressed: widget.onIconButtonPressed,
    smallBorderRadius: widget.maxLines > 1,
  );
}

/// [QUANTITY TEXTFIELD]

class AppQuantityFormField extends StatefulWidget {
  final double? width;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final bool enabled;
  final bool obscureText;
  final String? initialValue;
  final String? errorText;
  final String? labelText;
  final String? hintText;
  final IconData? suffixIcon;

  final TextAlign textAlign;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final int maxLines;
  final int minLines;

  final void Function(String) onChanged;
  final void Function(String?)? onSubmitted;
  final void Function(String?)? onSaved;
  final FormFieldValidator<String>? validator;
  final VoidCallback? onIconButtonPressed;

  const AppQuantityFormField({
    super.key,
    required this.onChanged,
    required this.validator,
    this.onSubmitted,
    this.onSaved,
    this.width,
    this.controller,
    this.inputFormatters,
    this.focusNode,
    this.keyboardType,
    this.enabled = true,
    this.labelText,
    this.errorText,
    this.hintText,
    this.suffixIcon,
    this.initialValue,
    this.onIconButtonPressed,
    this.obscureText = false,
    this.maxLines = 1,
    this.minLines = 1,
    this.textAlign = TextAlign.start,
  });

  @override
  State<AppQuantityFormField> createState() => _AppQuantityFormFieldState();
}

class _AppQuantityFormFieldState extends State<AppQuantityFormField> {
  late final FocusNode _keyboardListenerFocusNode;
  late final FocusNode _textFieldFocusNode;
  late bool hasFocus;
  late bool isFocusedWithKeyboard;

  @override
  void initState() {
    _keyboardListenerFocusNode = FocusNode();
    _textFieldFocusNode = FocusNode();
    _textFieldFocusNode.addListener(_onFocusChange);
    _keyboardListenerFocusNode.addListener(_onFocusChange);
    hasFocus = false;
    isFocusedWithKeyboard = false;
    super.initState();
  }

  @override
  void dispose() {
    _textFieldFocusNode.removeListener(_onFocusChange);
    // _keyboardListenerFocusNode.removeListener(_onFocusChange);
    _keyboardListenerFocusNode.dispose();
    _textFieldFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width ?? double.infinity,
      child: KeyboardListener(
        focusNode: _keyboardListenerFocusNode,
        onKeyEvent: (KeyEvent event) {
          if (event is KeyDownEvent &&
              event.logicalKey == LogicalKeyboardKey.tab) {
            isFocusedWithKeyboard = true;
          }
        },
        child: TextFormField(
          initialValue: widget.initialValue,
          decoration: _buildDecoration(),
          inputFormatters: widget.inputFormatters,
          textAlign: widget.textAlign,
          controller: widget.controller,
          focusNode: widget.focusNode,
          keyboardType: widget.keyboardType,
          enabled: widget.enabled,
          style: context.bodyRegularTextStyle,
          maxLines: widget.maxLines,
          minLines: widget.minLines,
          onChanged: widget.onChanged,
          onFieldSubmitted: widget.onSubmitted,
          onSaved: widget.onSaved,
          validator: widget.validator,
        ),
      ),
    );
  }

  void _onFocusChange() {
    setState(() {
      hasFocus = _keyboardListenerFocusNode.hasFocus;
      if (!_keyboardListenerFocusNode.hasFocus) {
        isFocusedWithKeyboard = false;
      }
    });
  }

  InputDecoration _buildDecoration() => AppTheme.textFieldDecoration(
    context,
    showFocusedBorder: hasFocus && isFocusedWithKeyboard,
    labelText: widget.hintText,
    hintText: widget.hintText,
    suffixIcon: widget.suffixIcon,
    errorText: widget.errorText,
    isEnabled: widget.enabled,
    onIconButtonPressed: widget.onIconButtonPressed,
    smallBorderRadius: widget.maxLines > 1,
  );
}
