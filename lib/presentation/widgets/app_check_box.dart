import 'package:flutter/material.dart';
import 'package:sigev/config/theme/app_theme.dart';

class AppCheckBox extends StatefulWidget {
  const AppCheckBox({
    super.key,
    this.value,
    required this.label,
    this.onChanged,
    this.focusNode,
  });

  final bool? value;
  final void Function(bool?)? onChanged;
  final String label;
  final FocusNode? focusNode;

  @override
  State<AppCheckBox> createState() => _AppCheckBoxState();
}

class AppCheckBoxState {
  final bool isHovered;
  final bool isFocused;
  AppCheckBoxState({required this.isHovered, required this.isFocused});

  AppCheckBoxState copyWith({bool? isHovered, bool? isFocused}) {
    return AppCheckBoxState(
      isHovered: isHovered ?? this.isHovered,
      isFocused: isFocused ?? this.isFocused,
    );
  }
}

class _AppCheckBoxState extends State<AppCheckBox> {
  late AppCheckBoxState _state;
  @override
  void initState() {
    _state = AppCheckBoxState(isFocused: false, isHovered: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // For this checkbox there are three possible values: true, false, null
        // False, the checkbox is unchecked and null, the checkbox is indeterminate
        // The cycle goes false => true => null => false
        FormField<bool?>(
          validator: (value) => null,
          builder: (field) => Stack(
            alignment: Alignment.center,
            children: [
              if (_state.isHovered || _state.isFocused)
                Positioned.fill(
                  child: Container(
                    width: 500,
                    height: 500,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _state.isFocused
                          ? AppTheme.neutralColorGrey400
                          : _state.isHovered
                          ? AppTheme.neutralColorGrey100
                          : null, // Colors.transparent
                    ),
                  ),
                ),
              SizedBox(
                width: context.spacing32,
                height: context.spacing32,
                child: InkWell(
                  focusNode: widget.focusNode,
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: widget.onChanged == null
                      ? null
                      : () {
                          widget.onChanged!(!widget.value!);
                        },
                  onFocusChange: (value) => setState(
                    () => _state = _state.copyWith(isFocused: value),
                  ),
                  onHover: (value) => setState(
                    () => _state = _state.copyWith(isHovered: value),
                  ),
                  child: Icon(
                    (widget.value ?? false)
                        ? Icons.check_box_rounded
                        : Icons.check_box_outline_blank_rounded,
                    color: widget.onChanged == null
                        ? AppTheme.neutralColorGrey400
                        : (widget.value ?? false)
                        ? AppTheme.primaryColor
                        : Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          child: Text(
            widget.label,
            style: context.bodyRegularTextStyle.copyWith(
              color: widget.onChanged == null
                  ? AppTheme.neutralColorGrey400
                  : null,
            ),
          ),
        ),
      ],
    );
  }
}
