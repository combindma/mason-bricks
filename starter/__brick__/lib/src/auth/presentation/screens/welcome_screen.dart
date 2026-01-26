import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../bootstrap/remote_config_provider.dart';
import '../../../../config/app_config.dart';
import '../../../../core/extensions/extensions.dart';
import '../../../../core/utils/device_helper.dart';
import '../../../../routes/routes.dart';
import '../../../../shared/theme/spacing.dart';
import '../../../../shared/ui/svg_logo.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

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
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: BaseSpacing.containerPadding, vertical: BaseSpacing.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SvgLogoComponent(),
                    const SizedBox(height: 20),
                    Text('welcome.title'.tr(namedArgs: {'appName': AppConfig.name}), style: context.headlineSmall).centered(),
                    const SizedBox(height: 10),
                    Text('welcome.description'.tr(namedArgs: {'appName': AppConfig.name}), style: context.bodyMedium).centered(),
                  ],
                ),
              ),
              Consumer(
                builder: (context, ref, child) {
                  final config = ref.read(remoteConfigProvider).requireValue;
                  return RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: Theme.of(context).textTheme.bodySmall,
                      text: 'welcome.terms_intro'.tr(namedArgs: {'appName': AppConfig.name}),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'welcome.terms_link'.tr(),
                          style: const TextStyle(decoration: TextDecoration.underline),
                          recognizer: TapGestureRecognizer()..onTap = () => DeviceHelper.launchLink(config.cgvUrl),
                        ),
                        const TextSpan(text: ' '),
                        TextSpan(text: 'and'.tr()),
                        const TextSpan(text: ' '),
                        TextSpan(
                          text: 'welcome.privacy_link'.tr(),
                          style: const TextStyle(decoration: TextDecoration.underline),
                          recognizer: TapGestureRecognizer()..onTap = () => DeviceHelper.launchLink(config.privacyUrl),
                        ),
                      ],
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(onPressed: () => context.pushNamed(Routes.signup.name), child: Text('sign up'.tr())),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () => context.pushNamed(Routes.login.name),
                  child: Text('log in'.tr()),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
