import 'package:flutter/material.dart';

import '../spacing.dart';

class DraggableSheetComponent extends StatelessWidget {
  const DraggableSheetComponent({
    super.key,
    required this.child,
    this.initialChildSize = 0.9,
    this.minChildSize = 0,
    this.maxChildSize = 1.0,
  });

  final double initialChildSize;
  final double minChildSize;
  final double maxChildSize;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;
    return DraggableScrollableSheet(
      initialChildSize: initialChildSize,
      minChildSize: minChildSize,
      maxChildSize: maxChildSize,
      builder: (BuildContext context, ScrollController scrollController) {
        return Container(
          padding: const EdgeInsets.only(
            top: BaseSpacing.defaultSpace,
            left: BaseSpacing.defaultSpace,
            bottom: BaseSpacing.defaultSpace,
            right: BaseSpacing.defaultSpace,
          ),
          decoration: BoxDecoration(
            color: dark ? Colors.white.withValues(alpha: 0.12) : Colors.white,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30.0),
              topRight: Radius.circular(30.0),
            ),
            child: child,
          ),
        );
      },
    );
  }
}
