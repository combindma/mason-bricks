import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../../../core/extensions/context_extensions.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: DecoratedBox(
        position: DecorationPosition.foreground,
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(color: context.isDarkMode ? Colors.grey.shade700 : Colors.grey.shade400, width: 0.5),
          ),
        ),
        child: NavigationBar(
          selectedIndex: navigationShell.currentIndex,
          onDestinationSelected: navigationShell.goBranch,
          destinations: [
            NavigationDestination(
              icon: HugeIcon(icon: HugeIcons.strokeRoundedHome04),
              selectedIcon: HugeIcon(icon: HugeIcons.strokeRoundedHome04),
              label: 'home'.tr(),
            ),
            NavigationDestination(
              icon: HugeIcon(icon: HugeIcons.strokeRoundedUser),
              selectedIcon: HugeIcon(icon: HugeIcons.strokeRoundedUser),
              label: 'account'.tr(),
            ),
          ],
        ),
      ),
    );
  }
}
