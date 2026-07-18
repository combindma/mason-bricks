import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../bootstrap/error_provider.dart';
import 'show_toast.dart';

class AppErrorListener extends ConsumerWidget {
  final Widget child;

  const AppErrorListener({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<ErrorEvent?>(globalErrorProvider, (previous, next) {
      if (next != null) {
        showAppToast(isError: true, message: next.message);
      }
    });

    return child;
  }
}
