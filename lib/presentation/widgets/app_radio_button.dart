import 'package:flutter/material.dart';
import 'package:sigev/config/theme/app_theme.dart';

class AppRadioButton<T> extends StatefulWidget {
  const AppRadioButton({
    super.key,
    required this.label,
    required this.value,
    required this.groupValue,
    this.onChanged,
  });

  final String label;
  final T value;
  final T? groupValue;
  final ValueChanged<T?>? onChanged;

  @override
  State<AppRadioButton<T>> createState() => _AppRadioButtonState<T>();
}

class AppRadioButtonState {
  final bool isHovered;
  final bool isFocused;
  AppRadioButtonState({required this.isHovered, required this.isFocused});

  AppRadioButtonState copyWith({bool? isHovered, bool? isFocused}) {
    return AppRadioButtonState(
      isHovered: isHovered ?? this.isHovered,
      isFocused: isFocused ?? this.isFocused,
    );
  }
}

class _AppRadioButtonState<T> extends State<AppRadioButton<T>> {
  late AppRadioButtonState _state;
  @override
  void initState() {
    _state = AppRadioButtonState(isFocused: false, isHovered: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
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
                          ? AppTheme.neutralColorLightGrey
                          : _state.isHovered
                          ? AppTheme.neutralColorBg
                          : null, // Colors.transparent
                    ),
                  ),
                ),
              SizedBox(
                width: context.spacing32,
                height: context.spacing32,
                child: InkWell(
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: widget.onChanged == null
                      ? null
                      : () {
                          widget.onChanged!(widget.value!);
                        },
                  onFocusChange: (value) => setState(
                    () => _state = _state.copyWith(isFocused: value),
                  ),
                  onHover: (value) => setState(
                    () => _state = _state.copyWith(isHovered: value),
                  ),
                  child: Icon(
                    (widget.value == widget.groupValue)
                        ? Icons.radio_button_on
                        : Icons.radio_button_off,
                    color: widget.onChanged == null
                        ? AppTheme.neutralColorLightGrey
                        : (widget.value == widget.groupValue)
                        ? AppTheme.primaryColor
                        : Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
        // SizedBox(
        //   width: context.spacing32,
        //   height: context.spacing32,
        //   child: Radio<T>(
        //     value: widget.value,
        //     groupValue: widget.groupValue,
        //     onChanged: widget.onChanged,
        //   ),
        // ),
        SizedBox(width: context.spacing4),
        Flexible(
          child: Text(
            widget.label,
            style: context.bodyRegularTextStyle.copyWith(
              color: widget.onChanged == null
                  ? AppTheme.neutralColorLightGrey
                  : null,
            ),
          ),
        ),
      ],
    );
  }
}
