import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../bootstrap/connectivity_provider.dart';
import '../../core/extensions/extensions.dart';

class OfflineScreen extends ConsumerWidget {
  const OfflineScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: .spaceBetween,
            crossAxisAlignment: .center,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: .center,
                  crossAxisAlignment: .center,
                  children: [
                    HugeIcon(icon: HugeIcons.strokeRoundedNoInternet, size: 64, color: context.isDarkMode ? Colors.orange.shade300 : Colors.orange),
                    const SizedBox(height: 24),
                    Text('offline_screen.title'.tr(), style: context.headlineSmall).centered(),
                    const SizedBox(height: 12),
                    Text(
                      'offline_screen.description'.tr(),
                      style: context.bodyLarge,
                    ).centered().withColor(context.isDarkMode ? Colors.grey.shade300 : Colors.grey.shade600),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: ()  => ref.read(connectivityProvider.notifier).retry(),
                  child: Row(
                    mainAxisSize: .max,
                    mainAxisAlignment: .center,
                    spacing: 15.0,
                    children: [
                      HugeIcon(icon: HugeIcons.strokeRoundedRefresh, size: 18),
                      const Text('offline_screen.action').tr(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
