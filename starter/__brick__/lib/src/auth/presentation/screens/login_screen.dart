import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/extensions/extensions.dart';
import '../../../../routes/routes.dart';
import '../../../../shared/theme/spacing.dart';
import '../../../../shared/ui/svg_logo.dart';
import '../controllers/auth_notifier_provider.dart';
import '../controllers/auth_state.dart';
import '../widgets/social_login.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: context.isDarkMode ? Colors.grey.shade800 : Colors.grey.shade300,
              foregroundColor: context.isDarkMode ? Colors.grey : Colors.black,
              shape: CircleBorder(),
              padding: EdgeInsets.all(10),
            ),
            onPressed: () => context.goNamed(Routes.home.name),
            child: Icon(Icons.close),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: BaseSpacing.containerPadding, vertical: BaseSpacing.defaultSpace),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 100),
              const SvgLogoComponent(),
              const SizedBox(height: 14),
              Text('login.title'.tr(), style: context.headlineSmall, textAlign: TextAlign.center),
              const SizedBox(height: 40),
              const SocialLogin(),
              Consumer(
                builder: (context, ref, child) {
                  final authState = ref.watch(authNotifierProvider);
                  if (authState.isAuthenticating) {
                    return SizedBox.shrink();
                  }

                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.grey.shade200, foregroundColor: Colors.grey.shade800),
                          onPressed: () => context.pushNamed(Routes.loginForm.name),
                          child: Text('login.continue_email'.tr()),
                        ),
                      ),
                      const SizedBox(height: 24),
                      Text(style: context.labelMedium, 'login.no_account'.tr()),
                      TextButton(
                        onPressed: () => context.pushNamed(Routes.signup.name),
                        child: Text('sign up'.tr(), style: context.bodyMedium).bold,
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
