import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../routes/go_router.dart';
import '../../shared/theme/spacing.dart';
import '../extensions/extensions.dart';

Future<void> showAppBottomSheet<T>({
  required WidgetRef ref,
  required Widget child,
  bool isScrollControlled = true,
}) {
  final rootNavigator = ref.read(rootNavigatorKeyProvider).currentState;
  if (rootNavigator == null) return Future.value();
  final context = rootNavigator.context;

  return showModalBottomSheet<void>(
    context: context,
    useRootNavigator: true,
    isScrollControlled: isScrollControlled,
    barrierColor: Colors.black.withValues(alpha: 0.4),
    backgroundColor: context.isDarkMode ? Colors.grey.shade900 : Colors.white,
    builder: (sheetContext) {
      return Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(sheetContext).viewInsets.bottom,
        ),
        child: SingleChildScrollView(
          padding: EdgeInsets.only(
            left: BaseSpacing.containerPadding,
            right: BaseSpacing.containerPadding,
            bottom: 23.0,
          ),
          child: child,
        ),
      );
    },
  );
}