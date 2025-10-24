import 'package:flutter/material.dart';
import 'package:sigev/config/theme/app_theme.dart';

class AppSwitch extends StatefulWidget {
  final Function(bool) onChanged;
  final bool isSelected;
  const AppSwitch({
    super.key,
    required this.onChanged,
    required this.isSelected,
  });

  @override
  State<AppSwitch> createState() => _AppSwitchState();
}

class _AppSwitchState extends State<AppSwitch>
    with SingleTickerProviderStateMixin {
  late AppSwitchState _state;
  @override
  void initState() {
    _state = AppSwitchState(isFocused: false, isHovered: false);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: .8, // Aumenta o reduce el tamaño general
      child: InkWell(
        focusColor: Colors.transparent,
        hoverColor: Colors.transparent,
        splashColor: Colors.transparent,
        onFocusChange: (value) =>
            setState(() => _state = _state.copyWith(isFocused: value)),
        child: Container(
          height: 37,
          width: 57,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            border: Border.all(
              color: _state.isFocused
                  ? AppTheme.semanticColorInfo
                  : Colors.transparent,
              width: 4,
            ),
          ),
          child: Switch(
            value: widget.isSelected,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            activeColor: AppTheme.neutralColorWhite,
            inactiveTrackColor: AppTheme.neutralColorGrey700,
            activeTrackColor: AppTheme.semanticColorSuccess,
            inactiveThumbColor: AppTheme.neutralColorWhite,
            trackOutlineColor: WidgetStateProperty.resolveWith<Color?>((
              Set<WidgetState> states,
            ) {
              if (states.contains(WidgetState.selected)) {
                return Colors.transparent;
              }
              return AppTheme.neutralColorGrey700;
            }),
            onChanged: (value) => widget.onChanged(value),
          ),
        ),
      ),
    );
  }
}

class AppSwitchState {
  final bool isHovered;
  final bool isFocused;
  AppSwitchState({required this.isHovered, required this.isFocused});

  AppSwitchState copyWith({bool? isHovered, bool? isFocused}) {
    return AppSwitchState(
      isHovered: isHovered ?? this.isHovered,
      isFocused: isFocused ?? this.isFocused,
    );
  }
}
