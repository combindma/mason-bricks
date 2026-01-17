import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../bootstrap/error_provider.dart';

class AppErrorListener extends ConsumerWidget {
  final Widget child;

  const AppErrorListener({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<ErrorEvent?>(globalErrorProvider, (previous, next) {
      if (next != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(next.message),
            backgroundColor: Colors.redAccent,
            behavior: SnackBarBehavior.floating,
            action: SnackBarAction(
              label: 'Fermer',
              textColor: Colors.white,
              onPressed: () {},
            ),
          ),
        );
      }
    });

    return child;
  }
}