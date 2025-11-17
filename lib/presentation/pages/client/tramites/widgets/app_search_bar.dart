import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:sigev/config/theme/app_icons.dart';
import 'package:sigev/core/constant/strings.dart';
import 'package:sigev/presentation/widgets/app_inputs.dart';

class AppSearchBar<T> extends StatefulWidget {
  final List<T> items;
  final ValueChanged<List<T>> onSearch;
  final bool Function(T item, String query) searchPredicate;

  const AppSearchBar({
    super.key,
    required this.items,
    required this.onSearch,
    required this.searchPredicate,
  });

  @override
  State<AppSearchBar<T>> createState() => _AppSearchBarState<T>();
}

class _AppSearchBarState<T> extends State<AppSearchBar<T>> {
  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AppTextFormField(
      controller: _textController,
      hintText: AppLocale.inputSearch.getString(context),
      validator: (value) {
        return null;
      },
      onChanged: (_) => _search(),
      onSubmitted: (_) => _search(),
      suffixIcon: _textController.text.isNotEmpty
          ? AppIcons.close
          : AppIcons.search,
      onIconButtonPressed: _textController.text.isNotEmpty
          ? _clearSearch
          : null,
    );
  }

  void _search() {
    String value = _textController.text;
    List<T> filtered = value.isEmpty
        ? widget.items
        : widget.items.where((e) => widget.searchPredicate(e, value)).toList();
    widget.onSearch(filtered);
  }

  void _clearSearch() {
    _textController.clear();
    widget.onSearch(widget.items);
  }
}
