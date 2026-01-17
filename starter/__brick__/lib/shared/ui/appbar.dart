import 'package:go_router/go_router.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../theme/spacing.dart';


class AppBarComponent extends StatelessWidget implements PreferredSizeWidget {
  const AppBarComponent({
    super.key,
    required this.title,
    this.actions = const [],
    this.showBackArrow = true,
    this.centerTitle = false,
  });

  final Widget? title;
  final bool showBackArrow;
  final bool centerTitle;
  final List<Widget> actions;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: showBackArrow ? const EdgeInsets.only(right: BaseSpacing.containerPadding) : const EdgeInsets.symmetric(horizontal: BaseSpacing.containerPadding),
      child: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: centerTitle,
        titleSpacing: 0,
        leading: showBackArrow
            ? IconButton(
                padding: const EdgeInsets.all(6.0),
                constraints: const BoxConstraints(),
                onPressed: () {
                  context.pop();
                },
                icon: const Icon(CupertinoIcons.back),
                iconSize: 22,
                color: Theme.of(context).colorScheme.onSurface,
              )
            : null,
        title: title,
        actions: actions,
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
