import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:sigev/config/theme/app_theme.dart';

class AppTab extends StatefulWidget {
  const AppTab({
    super.key,
    required this.isSelected,
    required this.title,
    this.onTap,
  });

  final bool isSelected;
  final String title;
  final VoidCallback? onTap;

  @override
  State<AppTab> createState() => _AppTabState();
}

class _AppTabState extends State<AppTab> {
  late AppTabState _state;

  @override
  void initState() {
    _state = AppTabState(isHovered: false, isFocused: false, isPressed: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Colors.transparent,
      hoverColor: Colors.transparent,
      focusColor: Colors.transparent,
      splashColor: Colors.transparent,
      splashFactory: NoSplash.splashFactory,
      onTap: widget.onTap,
      onTapDown: (details) =>
          setState(() => _state = _state.copyWith(isPressed: true)),
      onTapUp: (details) =>
          setState(() => _state = _state.copyWith(isPressed: false)),
      onHover: (value) =>
          setState(() => _state = _state.copyWith(isHovered: value)),
      onFocusChange: (value) =>
          setState(() => _state = _state.copyWith(isFocused: value)),
      child: AnimatedContainer(
        height: double.infinity,
        duration: const Duration(milliseconds: 300),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          border: _state.isFocused
              ? Border.all(color: AppTheme.semanticColorInfo, width: 2)
              : null,
          color: _state.isPressed
              ? AppTheme.neutralColorLightGrey
              : _state.isHovered
              ? AppTheme.neutralColorWhite
              : _state.isFocused
              ? AppTheme.primaryColorDisabled
              : widget.isSelected
              ? AppTheme.primaryColor
              : null,
        ),
        child: Center(
          child: Text(
            widget.title,
            textAlign: TextAlign.center,
            style: widget.isSelected
                ? context.bodyBoldTextStyle.copyWith(
                    color: AppTheme.neutralColorWhite,
                  )
                : context.bodyBoldTextStyle.copyWith(
                    color: AppTheme.primaryColorHover,
                  ),
          ),
        ),
      ),
    );
  }
}

class AppTabState {
  final bool isHovered;
  final bool isFocused;
  final bool isPressed;
  AppTabState({
    required this.isHovered,
    required this.isFocused,
    required this.isPressed,
  });

  AppTabState copyWith({bool? isHovered, bool? isFocused, bool? isPressed}) {
    return AppTabState(
      isHovered: isHovered ?? this.isHovered,
      isFocused: isFocused ?? this.isFocused,
      isPressed: isPressed ?? this.isPressed,
    );
  }
}
