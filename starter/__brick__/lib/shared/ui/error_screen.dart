import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../core/extensions/extensions.dart';

class ErrorScreenComponent extends StatelessWidget {
  const ErrorScreenComponent({super.key, required this.onRetry});

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
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
                    HugeIcon(
                      icon: HugeIcons.strokeRoundedSettingsError01,
                      size: 64,
                      color: context.isDarkMode ? Colors.red.shade300 : Colors.red,
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'error_screen.title'.tr(),
                      style: context.headlineSmall,
                    ).centered(),
                    const SizedBox(height: 12),
                    Text(
                      'error_screen.description'.tr(),
                      style: context.bodyLarge,
                    ).centered().withColor(context.isDarkMode ? Colors.grey.shade300 : Colors.grey.shade600),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: onRetry,
                child: Row(
                  mainAxisSize: .max,
                  mainAxisAlignment: .center,
                  spacing: 15.0,
                  children: [
                    HugeIcon(icon: HugeIcons.strokeRoundedRefresh, size: 18,),
                    const Text('error_screen.action').tr(),
                  ],
                )
              ),
            ],
          ),
        ),
      ),
    );
  }
}