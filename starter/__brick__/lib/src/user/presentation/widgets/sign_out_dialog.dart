import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/extensions/extensions.dart';
import '../../../../routes/routes.dart';
import '../../../auth/presentation/controllers/auth_notifier_provider.dart';
import '../../../auth/presentation/controllers/auth_state.dart';

class SignOutDialog extends ConsumerWidget {
  const SignOutDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authNotifierProvider);
    final isLoading = authState.isAuthenticating;

    return AlertDialog.adaptive(
      actionsAlignment: MainAxisAlignment.center,
      title: Text('sign out'.tr()).centered(),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('are you sure you want to log out?'.tr(), style: context.bodyLarge,),
          if (isLoading) ...[const SizedBox(height: 20), CircularProgressIndicator.adaptive()],
        ],
      ),
      actions: [
        if (!isLoading) ...[
          TextButton(child: Text('cancel'.tr()).medium, onPressed: () => Navigator.of(context).pop()),
          TextButton(
            onPressed: () async {
              final success = await ref.read(authNotifierProvider.notifier).logout();
              if (success && context.mounted) {
                context.goNamed(Routes.welcome.name);
              }
            },
            style: TextButton.styleFrom(
              foregroundColor: Colors.red,
            ),
            child: Text('log out'.tr()).medium,
          ),
        ],
      ],
    );
  }
}