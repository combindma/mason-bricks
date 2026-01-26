import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../../../bootstrap/package_info_provider.dart';
import '../../../../bootstrap/remote_config_provider.dart';
import '../../../../bootstrap/theme_provider.dart';
import '../../../../config/app_config.dart';
import '../../../../core/extensions/extensions.dart';
import '../../../../core/utils/device_helper.dart';
import '../../../../routes/routes.dart';
import '../../../../shared/theme/spacing.dart';
import '../../../../shared/ui/section_divider.dart';
import '../../../auth/presentation/controllers/auth_notifier_provider.dart';
import '../../../auth/presentation/controllers/auth_state.dart';
import '../controllers/user_controller.dart';
import '../widgets/appearance_dialog.dart';
import '../widgets/list_tile_account_skeleton.dart';
import '../widgets/sign_out_dialog.dart';

class AccountScreen extends ConsumerWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final config = ref.read(remoteConfigProvider).requireValue;
    final packageInfo = ref.read(packageInfoProvider).requireValue;
    final authState = ref.watch(authNotifierProvider);

    return Scaffold(
      backgroundColor: context.isDarkMode ? Colors.black : Colors.grey.shade200,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: BaseSpacing.containerPadding, vertical: BaseSpacing.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('account'.tr(), style: context.headlineSmall).padVertical(10),
              const SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(color: context.isDarkMode ? Colors.grey.shade900 : Colors.white, borderRadius: BorderRadius.circular(20.0)),
                child: Consumer(
                  builder: (context, ref, child) {
                    if (authState.isAuthenticated) {
                      final userController = ref.watch(userControllerProvider);
                      if (userController.isLoading) {
                        return ListTileAccountSkeleton();
                      }

                      if (userController.error != null) {
                        return SizedBox.shrink();
                      }

                      return ListTile(
                        titleAlignment: ListTileTitleAlignment.center,
                        title: Text(
                          userController.requireValue?.name?.capitalized ?? 'profile'.tr(),
                          style: context.titleMedium,
                        ),
                        subtitle: Text('edit profile'.tr(), style: context.bodyMedium),
                        leading: const HugeIcon(icon: HugeIcons.strokeRoundedUser),
                        trailing: const HugeIcon(icon: HugeIcons.strokeRoundedArrowRight01),
                        onTap: () => context.pushNamed(Routes.editProfile.name),
                      );
                    }

                    return Column(
                      children: [
                        ListTile(
                          titleAlignment: ListTileTitleAlignment.center,
                          title: Text('sign up'.tr(), style: context.titleMedium),
                          leading: const HugeIcon(icon: HugeIcons.strokeRoundedUserAdd02),
                          onTap: () => context.goNamed(Routes.signup.name),
                        ),
                        const SectionDivider(),
                        ListTile(
                          titleAlignment: ListTileTitleAlignment.center,
                          title: Text('log in'.tr(), style: context.titleMedium),
                          leading: const HugeIcon(icon: HugeIcons.strokeRoundedLogin01),
                          onTap: () => context.goNamed(Routes.login.name),
                        ),
                      ],
                    );
                  },
                ),
              ),
              const SizedBox(height: 15),
              Container(
                decoration: BoxDecoration(color: context.isDarkMode ? Colors.grey.shade900 : Colors.white, borderRadius: BorderRadius.circular(20.0)),
                child: Consumer(
                  builder: (context, ref, child) {
                    final themeMode = ref.watch(themeControllerProvider).requireValue;
                    return ListTile(
                      titleAlignment: ListTileTitleAlignment.center,
                      leading: const HugeIcon(icon: HugeIcons.strokeRoundedPaintBoard),
                      title: Text('appearance'.tr(), style: context.bodyLarge),
                      subtitle: Text(themeMode.name.capitalized, style: context.bodyMedium),
                      trailing: const HugeIcon(icon: HugeIcons.strokeRoundedArrowRight01),
                      onTap: () async => await showAdaptiveDialog(context: context, builder: (_) => AppearanceDialog()),
                    );
                  },
                ),
              ),
              const SizedBox(height: 15),
              Container(
                decoration: BoxDecoration(color: context.isDarkMode ? Colors.grey.shade900 : Colors.white, borderRadius: BorderRadius.circular(20.0)),
                child: Column(
                  children: [
                    ListTile(
                      titleAlignment: ListTileTitleAlignment.center,
                      leading: const HugeIcon(icon: HugeIcons.strokeRoundedSecurityLock),
                      trailing: const HugeIcon(icon: HugeIcons.strokeRoundedArrowUpRight03),
                      title: Text('privacy_policy'.tr(), style: context.bodyLarge),
                      onTap: () => DeviceHelper.launchLink(config.privacyUrl),
                    ),
                    const SectionDivider(),
                    ListTile(
                      titleAlignment: ListTileTitleAlignment.center,
                      leading: const HugeIcon(icon: HugeIcons.strokeRoundedFile01),
                      trailing: const HugeIcon(icon: HugeIcons.strokeRoundedArrowUpRight03),
                      title: Text('terms_of_service'.tr(), style: context.bodyLarge),
                      onTap: () => DeviceHelper.launchLink(config.cgvUrl),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),
              Container(
                decoration: BoxDecoration(color: context.isDarkMode ? Colors.grey.shade900 : Colors.white, borderRadius: BorderRadius.circular(20.0)),
                child: Consumer(
                  builder: (context, ref, child) {
                    if (!authState.isAuthenticated) {
                      return SizedBox.shrink();
                    }
                    return ListTile(
                      titleAlignment: ListTileTitleAlignment.center,
                      leading: HugeIcon(icon: HugeIcons.strokeRoundedLogoutSquare02, color: Colors.red.shade300, strokeWidth: 2),
                      title: Text('sign out'.tr(), style: context.bodyLarge).withColor(Colors.red.shade500).medium,
                      onTap: () async => await showAdaptiveDialog(context: context, builder: (_) => SignOutDialog()),
                    );
                  },
                ),
              ),
              const SizedBox(height: 25),
              Align(
                alignment: Alignment.center,
                child: Text('copyright'.tr(namedArgs: {'year': DateTime.now().year.toString(), 'appName': AppConfig.name}), style: context.bodySmall),
              ),
              Align(
                alignment: Alignment.center,
                child: Text('copyright_version'.tr(namedArgs: {'version': packageInfo.version}), style: context.bodySmall),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
