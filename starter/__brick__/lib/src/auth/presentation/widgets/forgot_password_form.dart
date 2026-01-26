import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../../../core/extensions/extensions.dart';
import '../../../../shared/ui/btn_loading_indicator.dart';
import '../controllers/auth_notifier_provider.dart';
import '../controllers/auth_state.dart';

class ForgotPasswordForm extends HookWidget {
  const ForgotPasswordForm({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = useMemoized(() => GlobalKey<FormState>());
    final email = useTextEditingController();
    final isSent = useState(false);

    if (isSent.value) {
      return Column(
        mainAxisAlignment: .center,
        crossAxisAlignment: .center,
        children: [
          SizedBox(height: 15),
          HugeIcon(icon: HugeIcons.strokeRoundedInboxCheck, size: 80, color: Colors.deepOrangeAccent),
          SizedBox(height: 24),
          Text('reset_password.feedback', style: context.titleLarge).tr().padBottom(24),
          Text('reset_password.feedback_description', style: context.bodyLarge).tr().withColor(context.isDarkMode ? Colors.grey.shade200 : Colors.grey.shade800).centered(),
          SizedBox(height: 150),
        ],
      );
    }
    return Form(
      key: formKey,
      child: Column(
          crossAxisAlignment: .start,
          children: [
            Text('reset_password.title', style: context.titleLarge).tr().padBottom(12),
            Text('reset_password.description', style: context.bodyLarge).tr().withColor(context.isDarkMode ? Colors.grey.shade200 : Colors.grey.shade800).padBottom(40),
            Text('your email', style: context.labelMedium).tr().padVertical(6),
            TextFormField(
              autofocus: true,
              controller: email,
              validator: FormBuilderValidators.compose([FormBuilderValidators.required(), FormBuilderValidators.email()]),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: Consumer(
                builder: (context, ref, child) {
                  final authState = ref.watch(authNotifierProvider);
                  final isLoading = authState.isAuthenticating;
                  return ElevatedButton(
                    onPressed: isLoading
                        ? () {}
                        : () async {
                      if (formKey.currentState!.validate()) {
                        final success = await ref.read(authNotifierProvider.notifier).resetPassword(email: email.text.trim());
                        if (success) {
                          isSent.value = true;
                        }
                      }
                    },
                    child: isLoading ? const BtnLoadingIndicatorComponent() : Text('reset_password.action').tr(),
                  );
                },
              ),
            ),
            const SizedBox(height: 60),
          ]),
    );
  }
}
