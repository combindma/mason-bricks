import 'package:flutter/material.dart';

import '../../shared/theme/spacing.dart';
import '../extensions/extensions.dart';

Future<void> showAppBottomSheet<T>({
  required BuildContext context,
  required Widget child,
  bool isScrollControlled = true,
}) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: isScrollControlled,
    barrierColor: Colors.black.withValues(alpha: 0.4),
    backgroundColor: context.isDarkMode ? Colors.grey.shade900 : Colors.white,
    builder: (context) {
      return Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
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