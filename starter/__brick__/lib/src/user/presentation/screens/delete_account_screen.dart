import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../../../core/extensions/extensions.dart';
import '../../../../routes/routes.dart';
import '../../../../shared/theme/spacing.dart';
import '../../../../shared/ui/btn_loading_indicator.dart';
import '../../../auth/presentation/controllers/auth_notifier_provider.dart';
import '../../../auth/presentation/controllers/auth_state.dart';
import '../controllers/user_controller.dart';

class DeleteAccountScreen extends HookConsumerWidget {
  const DeleteAccountScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useMemoized(() => GlobalKey<FormState>());
    final password = useTextEditingController();
    final hidePassword = useState(true);
    final authState = ref.watch(authNotifierProvider);
    final userController = ref.watch(userControllerProvider).requireValue;
    final isLoading = authState.isAuthenticating;

    return Scaffold(
      backgroundColor: context.isDarkMode ? Colors.grey.shade900 : Colors.grey.shade100,
      appBar: AppBar(title: Text('delete account'.tr())),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: BaseSpacing.containerPadding, vertical: BaseSpacing.defaultSpace),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  Text('delete_account.title'.tr(), style: context.titleLarge),
                  const SizedBox(height: 20),
                  Text('delete_account.description'.tr(), style: context.bodyLarge),
                  const SizedBox(height: 30),
                  if (userController?.provider == 'email')
                    Form(
                      key: formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('your password'.tr(), style: context.labelMedium).padVertical(10),
                          TextFormField(
                            autofocus: false,
                            controller: password,
                            validator: FormBuilderValidators.required(),
                            obscureText: hidePassword.value,
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                onPressed: () {
                                  hidePassword.value == true ? hidePassword.value = false : hidePassword.value = true;
                                },
                                icon: hidePassword.value
                                    ? HugeIcon(icon: HugeIcons.strokeRoundedViewOff)
                                    : const HugeIcon(icon: HugeIcons.strokeRoundedView),
                              ),
                            ),
                          ),
                          const SizedBox(height: 15),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                              onPressed: isLoading
                                  ? () {}
                                  : () async {
                                      if (formKey.currentState!.validate()) {
                                        await _deleteAction(context, ref, password.text);
                                      }
                                    },
                              child: isLoading ? const BtnLoadingIndicatorComponent(isDestructive: true) : Text('delete account'.tr()),
                            ),
                          ),
                        ],
                      ),
                    ),
                  if (userController?.provider != 'email')
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                        onPressed: isLoading
                            ? () {}
                            : () async {
                                await _deleteAction(context, ref, null);
                              },
                        child: isLoading ? const BtnLoadingIndicatorComponent(isDestructive: true) : Text('delete account'.tr()),
                      ),
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Future<void> _deleteAction(BuildContext context, WidgetRef ref, String? password) async {
    final success = await ref.read(authNotifierProvider.notifier).removeAccount(password: password);
    if (success && context.mounted) {
      context.goNamed(Routes.welcome.name);
    }
  }
}
