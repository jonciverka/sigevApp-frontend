import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sigev/config/theme/app_theme.dart';

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

  late final bool _shouldDisposeController;

  late VoidCallback _controllerListener;
  late VoidCallback _focusListener;

  @override
  void initState() {
    super.initState();

    _focusNode = FocusNode();
    _shouldDisposeController = widget.controller == null;
    _controller = widget.controller ?? TextEditingController();

    _focusListener = () => setState(() {});
    _controllerListener = () {
      setState(() {});
    };

    _focusNode.addListener(_focusListener);
    _controller.addListener(_controllerListener);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_focusListener);

    _controller.removeListener(_controllerListener);

    if (_shouldDisposeController) {
      _controller.dispose();
    }

    _focusNode.dispose();

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
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.spacing4),
      child: Column(
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
                      LengthLimitingTextInputFormatter(
                        widget.maxLengthFormatter,
                      ),
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
                    onChanged: (value) {
                      widget.onChanged(value);
                      final result = widget.validator?.call(value);
                      setState(() {
                        errorMessage = result ?? '';
                      });
                      // return null;
                    },
                    onFieldSubmitted: widget.onSubmitted,
                    onSaved: widget.onSaved,
                    // autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      final result = widget.validator?.call(value);
                      setState(() {
                        errorMessage = result ?? '';
                      });
                      // return null;
                      return result;
                    },
                  ),
                ),
                if (widget.suffixIcon != null)
                  Icon(
                    widget.suffixIcon,
                    color: !widget.enabled
                        ? AppTheme.neutralColorDarkGrey
                        : AppTheme.neutralColorBlack,
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
