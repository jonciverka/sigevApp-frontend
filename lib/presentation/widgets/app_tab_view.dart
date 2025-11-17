import 'package:flutter/material.dart';
import 'package:sigev/config/theme/app_theme.dart';
import 'package:sigev/presentation/widgets/app_tabs.dart';

class AppTabView extends StatefulWidget {
  const AppTabView({
    super.key,
    required this.tabsNames,
    required this.children,
    this.controller,
    this.widgetsBetweenTabBarAndBody = const [],
    this.onChangeTab,
    this.isBarScrollable = true,
    this.isExpanded = true,
    this.showPadding = true,
    this.isBodyScrollable = true,
  }) : assert(tabsNames.length == children.length);

  final List<String> tabsNames;
  final List<Widget> children;
  final List<Widget> widgetsBetweenTabBarAndBody;
  final ValueChanged<int>? onChangeTab;
  final TabController? controller;
  final bool isBarScrollable;
  final bool isBodyScrollable;
  final bool showPadding;
  final bool isExpanded;
  @override
  State<AppTabView> createState() => _AppTabViewState();
}

class _AppTabViewState extends State<AppTabView> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController =
        widget.controller ??
        TabController(length: widget.tabsNames.length, vsync: this);
    super.initState();
    _tabController.addListener(_handleTabChange);
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabChange);
    _tabController.dispose();
    super.dispose();
  }

  void changeTab(int index) {
    // We set state so the widget rebuild itself so the selected tab con change type of text
    setState(() {
      _tabController.animateTo(index);
      widget.onChangeTab?.call(index);
    });
  }

  void _handleTabChange() {
    if (_tabController.indexIsChanging) return;
    final newIndex = _tabController.index;
    changeTab(newIndex);
  }

  void onTabTap(int index) {
    // We set state so the widget rebuild itself so the selected tab con change type of text
    setState(() {
      widget.onChangeTab?.call(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: TabBar(
                labelPadding: EdgeInsets.zero,
                isScrollable: widget.isBarScrollable,
                overlayColor: WidgetStateColor.resolveWith(
                  (states) => Colors.transparent,
                ),
                splashFactory: NoSplash.splashFactory,
                padding: EdgeInsets.zero,
                indicatorColor: AppTheme.primaryColor,
                indicatorSize: TabBarIndicatorSize.tab,
                dividerColor: AppTheme.neutralColorLightGrey,
                dividerHeight: 2,
                controller: _tabController,
                onTap: onTabTap,
                automaticIndicatorColorAdjustment: true,
                tabAlignment: widget.isBarScrollable
                    ? TabAlignment.start
                    : null,
                tabs: List.generate(
                  widget.tabsNames.length,
                  (int index) => Padding(
                    padding: EdgeInsets.only(
                      bottom: 2.0,
                      left: widget.showPadding ? 16.0 : 0,
                      right: widget.showPadding ? 16.0 : 0,
                    ),
                    child: AppTab(
                      isSelected: index == _tabController.index,
                      title: widget.tabsNames[index],
                      onTap: () => changeTab(index),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        ...widget.widgetsBetweenTabBarAndBody,
        if (widget.isExpanded)
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(top: context.spacing8),
              child: TabBarView(
                physics: widget.isBodyScrollable
                    ? null
                    : const NeverScrollableScrollPhysics(),
                controller: _tabController,
                children: List.generate(
                  widget.children.length,
                  (int index) => Padding(
                    padding: const EdgeInsets.only(right: 5.0, left: 5.0),
                    child: widget.children[index],
                  ),
                ),
              ),
            ),
          )
        else
          Flexible(
            child: Padding(
              padding: EdgeInsets.only(top: context.spacing8),
              child: TabBarView(
                physics: widget.isBodyScrollable
                    ? null
                    : const NeverScrollableScrollPhysics(),
                controller: _tabController,
                children: List.generate(
                  widget.children.length,
                  (int index) => Padding(
                    padding: const EdgeInsets.only(right: 5.0, left: 5.0),
                    child: widget.children[index],
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
