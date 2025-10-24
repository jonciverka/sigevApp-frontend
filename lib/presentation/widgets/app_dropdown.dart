import 'package:flutter/material.dart';
import 'package:sigev/config/theme/app_icons.dart';
import 'package:sigev/config/theme/app_theme.dart';

typedef LabelItemBuilder<T> = String Function(T item);
typedef DropDownValidator<T> = String? Function(T?);
typedef SelectItemValidation<T> = bool Function(T?);

class AppDropDown<T> extends StatefulWidget {
  const AppDropDown({
    super.key,
    required this.items,
    required this.onSelectItem,
    required this.hint,
    required this.labelBuilder,
    required this.validator,
    this.selectItemValidation,
    this.initialValue,
    this.enabled = true,
  });

  final List<T> items;
  final ValueChanged<T>? onSelectItem;
  final String hint;
  final LabelItemBuilder<T> labelBuilder;
  final DropDownValidator<T>? validator;
  final bool enabled;
  final T? initialValue;
  final SelectItemValidation<T>? selectItemValidation;
  @override
  State<AppDropDown<T>> createState() => _AppDropDownState<T>();
}

class _AppDropDownState<T> extends State<AppDropDown<T>>
    with SingleTickerProviderStateMixin {
  // Selected measure
  T? selectedItem;
  // Flag to know if the popup menu is open
  bool isOpen = false;
  // Animation controllers
  late AnimationController _controller;
  late Animation<double> _rotationAnimation;
  late AppDropDownState _state;

  @override
  void initState() {
    selectedItem = widget.initialValue;
    _state = AppDropDownState(isFocused: false, isHovered: false);
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _rotationAnimation = Tween(
      begin: 0.0,
      end: 0.5,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
    super.initState();
  }

  Color _getBackGroundColor() {
    if (_state.isHovered && widget.enabled) {
      return AppTheme.neutralColorGrey100;
    }

    return AppTheme.neutralColorWhite;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _changeSelectedItem(T? account) {
    setState(() {
      if (account != null) {
        selectedItem = account;
      }
    });
    _toggleAnimation();
  }

  void _toggleAnimation() {
    setState(() {
      isOpen = !isOpen;
      if (isOpen) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return FormField<T>(
      validator: (value) => widget.validator?.call(value),
      builder: (FormFieldState<T> field) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: MouseRegion(
                    onEnter: (event) => setState(
                      () => _state = _state.copyWith(isHovered: true),
                    ),
                    onExit: (event) => setState(
                      () => _state = _state.copyWith(isHovered: false),
                    ),
                    child: InkWell(
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      splashFactory: NoSplash.splashFactory,
                      onFocusChange: (value) => setState(
                        () => _state = _state.copyWith(isFocused: value),
                      ),
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          return PopupMenuButton<T>(
                            offset: const Offset(0, 0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            position: PopupMenuPosition.under,
                            initialValue: selectedItem,
                            menuPadding: const EdgeInsets.all(0),
                            tooltip: '',
                            color: AppTheme.neutralColorWhite,
                            enabled: widget.enabled,
                            elevation: 8,
                            constraints: BoxConstraints(
                              maxWidth: constraints.maxWidth,
                            ),
                            onCanceled: _toggleAnimation,
                            onSelected: _changeSelectedItem,
                            onOpened: _toggleAnimation,
                            itemBuilder: (BuildContext context) => widget.items
                                .map(
                                  (e) => CustomPopupMenuItem<T>(
                                    isSelected:
                                        widget.selectItemValidation?.call(e) ??
                                        false,
                                    isFirst: widget.items.first == e,
                                    isLast: widget.items.last == e,
                                    value: e,
                                    onTap: () => _onItemSelected(
                                      field,
                                      e,
                                      widget.onSelectItem,
                                    ),
                                    child: Text(
                                      widget.labelBuilder(e),
                                      style: context.bodyRegularTextStyle
                                          .copyWith(
                                            color: AppTheme.neutralColorGrey700,
                                          ),
                                    ),
                                  ),
                                )
                                .toList(),
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: context.spacing16,
                                vertical: context.spacing8,
                              ),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color:
                                    _getBackGroundColor(), // AppTheme.neutralColorWhite,
                                borderRadius: BorderRadius.circular(50),
                                border: Border.all(
                                  color: !widget.enabled
                                      ? AppTheme.neutralColorGrey400
                                      : field.hasError
                                      ? AppTheme.semanticColorError
                                      : _state.isFocused
                                      ? AppTheme.semanticColorInfo
                                      : AppTheme.neutralColorGrey700,
                                  width: context.spacing2,
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  if (selectedItem != null)
                                    Expanded(
                                      child: Text(
                                        widget.labelBuilder.call(
                                          selectedItem != null
                                              ? selectedItem!
                                              : widget.items.first,
                                        ),
                                        style: context.bodyRegularTextStyle
                                            .copyWith(
                                              color:
                                                  AppTheme.neutralColorGrey700,
                                            ),
                                      ),
                                    )
                                  else
                                    Expanded(
                                      child: Text(
                                        widget.hint,
                                        style: context.bodyRegularTextStyle
                                            .copyWith(
                                              color: widget.enabled
                                                  ? AppTheme.neutralColorGrey700
                                                  : AppTheme
                                                        .neutralColorGrey400,
                                            ),
                                      ),
                                    ),
                                  RotationTransition(
                                    turns: _rotationAnimation,
                                    child: AppIcons.mediumIcon(
                                      AppIcons.keyBoardArrowDown,
                                      color: !widget.enabled
                                          ? AppTheme.neutralColorGrey400
                                          : AppTheme.neutralColorGrey700,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
                if (selectedItem != null || isOpen)
                  Positioned(
                    top: 0,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 3),
                      margin: const EdgeInsets.only(left: 13),
                      color: Colors.white,
                      child: Text(
                        widget.hint,
                        style: context.bodyRegularInputStyle.copyWith(
                          fontSize: 9,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            if (field.hasError)
              Padding(
                padding: EdgeInsets.only(
                  top: context.spacing4,
                  left: context.spacing12,
                ),
                child: Text(
                  field.errorText!,
                  style: context.errorTextstStyle,
                  textAlign: TextAlign.left,
                ),
              ),
          ],
        );
      },
    );
  }

  void _onItemSelected(
    FormFieldState<T> field,
    e,
    ValueChanged<T>? onSelectItem,
  ) {
    field.didChange(e);
    field.validate();
    onSelectItem?.call(e);
  }
}

class AppDropDownState {
  final bool isHovered;
  final bool isFocused;
  AppDropDownState({required this.isHovered, required this.isFocused});

  AppDropDownState copyWith({bool? isHovered, bool? isFocused}) {
    return AppDropDownState(
      isHovered: isHovered ?? this.isHovered,
      isFocused: isFocused ?? this.isFocused,
    );
  }
}

class CustomPopupMenuItem<T> extends PopupMenuItem<T> {
  const CustomPopupMenuItem({
    super.key,
    required this.isSelected,
    required super.value,
    required super.child,
    required this.isFirst,
    required this.isLast,
    super.onTap,
  });

  final bool isSelected;
  final bool isFirst;
  final bool isLast;

  @override
  PopupMenuItemState<T, PopupMenuItem<T>> createState() =>
      _CustomPopupMenuItemState<T>();
}

class _CustomPopupMenuItemState<T>
    extends PopupMenuItemState<T, PopupMenuItem<T>> {
  late CustomPopupMenuItemState _state;

  @override
  void initState() {
    _state = CustomPopupMenuItemState(isFocused: false, isHovered: false);
    super.initState();
  }

  Color _getBackGroundColor() {
    final CustomPopupMenuItem<T> menuItem = widget as CustomPopupMenuItem<T>;
    if (menuItem.isSelected) {
      return AppTheme.neutralColorGrey400;
    }

    if (_state.isHovered) {
      return AppTheme.neutralColorGrey100;
    }

    return AppTheme.neutralColorWhite;
  }

  _getBorderRadius() {
    final CustomPopupMenuItem<T> menuItem = widget as CustomPopupMenuItem<T>;
    if (menuItem.isFirst && menuItem.isLast) {
      return BorderRadius.vertical(
        bottom: Radius.circular(context.spacing8),
        top: Radius.circular(context.spacing8),
      );
    } else if (menuItem.isLast && !menuItem.isFirst) {
      return BorderRadius.vertical(bottom: Radius.circular(context.spacing8));
    } else if (menuItem.isFirst && !menuItem.isLast) {
      return BorderRadius.vertical(top: Radius.circular(context.spacing8));
    } else {
      return BorderRadius.zero;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: _getBorderRadius(),
      child: InkWell(
        focusColor: Colors.transparent,
        hoverColor: Colors.transparent,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        splashFactory: NoSplash.splashFactory,
        onTap: super.handleTap,
        onHover: (value) =>
            setState(() => _state = _state.copyWith(isHovered: value)),
        onFocusChange: (value) =>
            setState(() => _state = _state.copyWith(isFocused: value)),
        borderRadius: _getBorderRadius(),
        child: AnimatedContainer(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          duration: const Duration(milliseconds: 200),
          width: MediaQuery.of(context).size.width,
          height: context.spacing40,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.2),
                offset: const Offset(4, 4),
                blurRadius: 6,
                spreadRadius: 1,
              ),
            ],
            color: _getBackGroundColor(),
            borderRadius: _getBorderRadius(),
            border: Border.all(
              color: _state.isFocused
                  ? AppTheme.semanticColorInfo
                  : Colors.transparent,
              width: 2,
            ),
          ),
          child: Align(alignment: Alignment.centerLeft, child: widget.child),
        ),
      ),
    );
  }
}

class CustomPopupMenuItemState {
  final bool isHovered;
  final bool isFocused;
  CustomPopupMenuItemState({required this.isHovered, required this.isFocused});

  CustomPopupMenuItemState copyWith({bool? isHovered, bool? isFocused}) {
    return CustomPopupMenuItemState(
      isHovered: isHovered ?? this.isHovered,
      isFocused: isFocused ?? this.isFocused,
    );
  }
}

// class AppDropDown<T> extends StatefulWidget {
//   const AppDropDown({
//     super.key,
//     required this.items,
//     this.selectedItem,
//     this.onValueChanged,
//     this.isEnable = true,
//     required this.itemLabelBuilder,
//     required this.hint,
//     // required this.state
//   });

//   final List<T> items;
//   final T? selectedItem;
//   final ValueChanged<T>? onValueChanged;
//   final bool isEnable;
//   final String hint;
//   final LabelItemBuilder<T> itemLabelBuilder;
//   // final FormFieldState<T> state;

//   @override
//   State<AppDropDown<T>> createState() => _AppDropDownState<T>();
// }

// class _AppDropDownState<T> extends State<AppDropDown<T>>
//     with SingleTickerProviderStateMixin {
//   // Selected measure
//   late T? selectedObject;
//   // Flag to know if the popup menu is open
//   bool isOpen = false;
//   // Animation controllers
//   late AnimationController _controller;
//   late Animation<double> _rotationAnimation;

//   @override
//   void initState() {
//     selectedObject = widget.selectedItem;
//     _controller = AnimationController(
//       duration: const Duration(milliseconds: 200),
//       vsync: this,
//     );
//     _rotationAnimation = Tween(begin: 0.0, end: 0.5).animate(
//       CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
//     );
//     super.initState();
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   void didUpdateWidget(covariant AppDropDown<T> oldWidget) {
//     if (widget.selectedItem != selectedObject) {
//       setState(() {
//         selectedObject = widget.selectedItem;
//       });
//     }
//     super.didUpdateWidget(oldWidget);
//   }

//   void _changeSelectedItem(T? measure) {
//     setState(() {
//       selectedObject = measure;
//     });
//     _toggleAnimation();
//   }

//   void _toggleAnimation() {
//     setState(() {
//       isOpen = !isOpen;
//       if (isOpen) {
//         _controller.forward();
//       } else {
//         _controller.reverse();
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: context.spacing16),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(context.spacing56),
//         border: Border.all(color: AppTheme.neutralColorGrey700, width: 2),
//       ),
//       child: PopupMenuButton<T>(
//         enabled: widget.isEnable,
//         offset: const Offset(0, 0),
//         position: PopupMenuPosition.under,
//         surfaceTintColor: Colors.transparent,
//         initialValue: selectedObject,
//         elevation: 8,
//         menuPadding: const EdgeInsets.all(0),
//         color: AppTheme.neutralColorWhite,
//         splashRadius: 16,
//         shadowColor: AppTheme.neutralColorGrey950,
//         shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(context.spacing8)),
//         onCanceled: _toggleAnimation,
//         onSelected: _changeSelectedItem,
//         onOpened: _toggleAnimation,
//         itemBuilder: (BuildContext context) => widget.items
//             .map((e) => CustomPopupMenuItem<T>(
//                 isSelected: selectedObject == e,
//                 isFirst: e == widget.items.first,
//                 isLast: e == widget.items.last,
//                 value: e,
//                 onTap: () => widget.onValueChanged?.call(e),
//                 child: SizedBox(
//                   width: MediaQuery.of(context).size.width,
//                   child: Text(widget.itemLabelBuilder.call(e),
//                       style: context.bodyRegularTextStyle
//                           .copyWith(color: AppTheme.neutralColorGrey700)),
//                 )))
//             .toList(),
//         child: SizedBox(
//             height: context.spacing32,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 if (selectedObject != null)
//                   Text(
//                       widget.itemLabelBuilder.call(selectedObject != null
//                           ? selectedObject!
//                           : widget.items.first),
//                       style: context.bodyRegularTextStyle
//                           .copyWith(color: AppTheme.neutralColorGrey700))
//                 else
//                   Text(widget.hint,
//                       style: context.bodyRegularTextStyle
//                           .copyWith(color: AppTheme.neutralColorGrey700)),
//                 // SizedBox(
//                 //   width: context.spacing4,
//                 // ),
//                 RotationTransition(
//                   turns: _rotationAnimation,
//                   child: AppIcons.smallIcon(AppIcons.keyBoardArrowDown,
//                       color: AppTheme.neutralColorGrey700),
//                 ),
//               ],
//             )),
//       ),
//     );
//   }
// }

// class CustomPopupMenuItem<T> extends PopupMenuItem<T> {
//   const CustomPopupMenuItem(
//       {super.key,
//       required this.isSelected,
//       required super.value,
//       required super.child,
//       required this.isFirst,
//       required this.isLast,
//       super.onTap});

//   final bool isSelected;
//   final bool isFirst;
//   final bool isLast;

//   @override
//   PopupMenuItemState<T, PopupMenuItem<T>> createState() =>
//       _CustomPopupMenuItemState<T>();
// }

// class _CustomPopupMenuItemState<T>
//     extends PopupMenuItemState<T, PopupMenuItem<T>> {
//   late CustomPopupMenuItemState _state;

//   @override
//   void initState() {
//     _state = CustomPopupMenuItemState(isFocused: false, isHovered: false);
//     super.initState();
//   }

//   Color _getBackGroundColor() {
//     final CustomPopupMenuItem<T> menuItem = widget as CustomPopupMenuItem<T>;
//     if (menuItem.isSelected) {
//       return AppTheme.neutralColorGrey400;
//     }

//     if (_state.isHovered) {
//       return AppTheme.neutralColorGrey100;
//     }

//     return AppTheme.neutralColorWhite;
//   }

//   @override
//   Widget build(BuildContext context) {
//     final CustomPopupMenuItem<T> menuItem = widget as CustomPopupMenuItem<T>;
//     return SizedBox(
//       width: double.infinity,
//       child: InkWell(
//         highlightColor: Colors.transparent,
//         hoverColor: Colors.transparent,
//         focusColor: Colors.transparent,
//         splashColor: Colors.transparent,
//         splashFactory: NoSplash.splashFactory,
//         borderRadius: BorderRadius.circular(context.spacing8),
//         onTap: super.handleTap,
//         onHover: (value) =>
//             setState(() => _state = _state.copyWith(isHovered: value)),
//         onFocusChange: (value) =>
//             setState(() => _state = _state.copyWith(isFocused: value)),
//         child: AnimatedContainer(
//           duration: const Duration(milliseconds: 200),
//           width: double.infinity,
//           height: context.spacing40,
//           decoration: BoxDecoration(
//               color: _getBackGroundColor(),
//               borderRadius: menuItem.isFirst
//                   ? BorderRadius.vertical(
//                       top: Radius.circular(context.spacing8))
//                   : menuItem.isLast
//                       ? BorderRadius.vertical(
//                           bottom: Radius.circular(context.spacing8))
//                       : null,
//               border: Border.all(
//                 color: _state.isFocused
//                     ? AppTheme.semanticColorInfo
//                     : Colors.transparent,
//                 width: 2,
//               )),
//           child: Align(alignment: Alignment.centerLeft, child: widget.child),
//         ),
//       ),
//     );
//   }
// }

// class CustomPopupMenuItemState {
//   final bool isHovered;
//   final bool isFocused;
//   CustomPopupMenuItemState({
//     required this.isHovered,
//     required this.isFocused,
//   });

//   CustomPopupMenuItemState copyWith({
//     bool? isHovered,
//     bool? isFocused,
//   }) {
//     return CustomPopupMenuItemState(
//       isHovered: isHovered ?? this.isHovered,
//       isFocused: isFocused ?? this.isFocused,
//     );
//   }
// }
