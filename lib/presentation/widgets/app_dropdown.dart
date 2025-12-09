import 'package:flutter/material.dart';
import 'package:sigev/config/theme/app_icons.dart';
import 'package:sigev/config/theme/app_theme.dart';
import 'package:sigev/presentation/pages/client/tramites/widgets/app_search_bar.dart';
import 'package:sigev/presentation/widgets/app_bottom_sheet.dart';
import 'package:sigev/presentation/widgets/app_inputs.dart';

typedef LabelItemBuilder<T> = String Function(T item);
typedef DropDownValidator<T> = String? Function(T?);

class AppDropDown<T> extends StatelessWidget {
  AppDropDown({
    super.key,
    required this.items,
    required this.onSelectItem,
    required this.hint,
    required this.labelBuilder,
    required this.validator,
    this.initialValue,
  });

  final List<T> items;
  final ValueChanged<T> onSelectItem;
  final String hint;
  final LabelItemBuilder<T> labelBuilder;
  final DropDownValidator<String> validator;
  final T? initialValue;
  final _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (initialValue != null && initialValue is T) {
      _textController.text = labelBuilder(initialValue as T);
    }
    return GestureDetector(
      onTap: () => showAppBottomSheet(
        context: context,
        title: hint,
        child: _BodyBottomSheet<T>(
          items: items,
          onSelectItem: (value) => onSelectItem(value),
          labelBuilder: labelBuilder,
          initialValue: initialValue,
          textController: _textController,
        ),
      ),
      child: AbsorbPointer(
        child: AppTextFormField(
          labelText: hint,
          validator: (value) => validator(value),
          controller: _textController,
          onChanged: (_) {},
          suffixIcon: AppIcons.arrowDown,
          readOnly: true,
          onTap: () => {},
        ),
      ),
    );
  }
}

class _BodyBottomSheet<T> extends StatefulWidget {
  const _BodyBottomSheet({
    super.key,
    required this.items,
    required this.onSelectItem,
    required this.labelBuilder,
    this.initialValue,
    required this.textController,
  });
  final List<T> items;
  final ValueChanged<T> onSelectItem;
  final LabelItemBuilder<T> labelBuilder;
  final T? initialValue;
  final TextEditingController textController;
  @override
  State<_BodyBottomSheet<T>> createState() => _BodyBottomSheetState<T>();
}

class _BodyBottomSheetState<T> extends State<_BodyBottomSheet<T>> {
  T? selectedItem;
  List itemsSearch = [];
  @override
  void initState() {
    selectedItem = widget.initialValue;
    itemsSearch = widget.items;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          SizedBox(height: context.spacing8),
          AppSearchBar<T>(
            items: widget.items,
            onSearch: (results) {
              setState(() {
                itemsSearch = results;
              });
            },
            searchPredicate: (item, query) {
              return widget
                  .labelBuilder(item)
                  .toString()
                  .toLowerCase()
                  .contains(query.toLowerCase());
            },
          ),
          SizedBox(height: context.spacing16),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              "Total de elementos (${itemsSearch.length})",
              style: context.captionBoldTextStyle.copyWith(
                color: AppTheme.neutralColorDarkGrey,
              ),
            ),
          ),
          SizedBox(height: context.spacing8),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: itemsSearch
                    .map(
                      (e) => CustomPopupMenuItem<T>(
                        isSelected: selectedItem == e ? true : false,
                        isFirst: widget.items.first == e,
                        isLast: widget.items.last == e,
                        value: e,
                        onTap: () {
                          widget.textController.text = widget.labelBuilder(e);
                          widget.onSelectItem(e);
                        },
                        child: Text(
                          widget.labelBuilder(e),
                          style: e == selectedItem
                              ? context.bodyBoldTextStyle
                              : context.bodyRegularTextStyle,
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
        ],
      ),
    );
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
      return AppTheme.neutralColorLightGrey;
    }

    if (_state.isHovered) {
      return AppTheme.neutralColorBg;
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
