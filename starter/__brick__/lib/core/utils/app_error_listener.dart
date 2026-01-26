import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../core/extensions/extensions.dart';
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
            content: Row(
              children: [
                HugeIcon(icon: HugeIcons.strokeRoundedAlertSquare, color: Colors.white, size: 20),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(next.message, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)).withColor(Colors.white),
                ),
              ],
            ),
            backgroundColor: Colors.redAccent.shade200,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            elevation: 0,
            duration: const Duration(seconds: 3),
            dismissDirection: DismissDirection.horizontal,
          ),
        );
      }
    });

    return child;
  }
}
