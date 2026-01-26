import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/extensions/extensions.dart';
import '../../../../shared/theme/logos.dart';
import '../controllers/auth_notifier_provider.dart';
import '../controllers/auth_state.dart';

class SocialLogin extends ConsumerWidget {
  const SocialLogin({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authNotifierProvider);

    if (authState.isAuthenticating) {
      return SizedBox(
        height: 110,
        child: Center(child: CircularProgressIndicator.adaptive()),
      );
    }

    return Column(
      spacing: 15,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (Platform.isIOS)
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: context.isDarkMode ? Colors.white : Colors.black,
                foregroundColor: context.isDarkMode ? Colors.black : Colors.white,
                textStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 11),
                side: const BorderSide(color: Colors.transparent),
              ),
              onPressed: () async {
                await ref.watch(authNotifierProvider.notifier).loginWithApple();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image(
                    image: context.isDarkMode ? const AssetImage(BaseLogos.apple) : const AssetImage(BaseLogos.appleAlt),
                    width: 24,
                    height: 24,
                  ),
                  const SizedBox(width: 10),
                  Text('login.continue_apple'.tr()),
                ],
              ),
            ),
          ),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Colors.grey.shade800,
              textStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 11),
              side: BorderSide(color: Colors.grey.shade100),
              elevation: 2,
            ),
            onPressed: () async {
              await ref.watch(authNotifierProvider.notifier).loginWithGoogle();
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Image(
                  image: AssetImage(BaseLogos.google),
                  width: 24,
                  height: 24,
                ),
                const SizedBox(width: 10),
                Text('login.continue_google'.tr())
              ],
            ),
          ),
        ),
      ],
    );
  }
}