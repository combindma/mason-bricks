import 'package:flutter/material.dart';

class TabBarComponent extends StatelessWidget {
  const TabBarComponent({super.key, required this.tabs, required this.controller, required this.onTap});

  final List<Widget> tabs;
  final TabController controller;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: TabBar(
        controller: controller,
        onTap: onTap,
        isScrollable: true,
        padding: const EdgeInsets.only(top: 0),
        tabs: tabs,
      ),
    );
  }
}
