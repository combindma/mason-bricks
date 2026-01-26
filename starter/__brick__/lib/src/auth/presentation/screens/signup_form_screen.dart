import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../../../core/extensions/extensions.dart';
import '../../../../shared/theme/spacing.dart';
import '../../../../shared/ui/btn_loading_indicator.dart';
import '../controllers/auth_notifier_provider.dart';
import '../controllers/auth_state.dart';

class SignUpFormScreen extends HookWidget {
  const SignUpFormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = useMemoized(() => GlobalKey<FormState>());
    final hidePassword = useState(true);
    final name = useTextEditingController();
    final email = useTextEditingController();
    final password = useTextEditingController();

    return Scaffold(
      appBar: AppBar(title: Text('signup.title'.tr())),
      body: SafeArea(
        child: Form(
          key: formKey,
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: BaseSpacing.containerPadding, vertical: BaseSpacing.defaultSpace),
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight - BaseSpacing.defaultSpace * 2),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('your name'.tr(), style: context.labelMedium).padVertical(10),
                          TextFormField(
                            autofocus: true,
                            controller: name,
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(),
                              FormBuilderValidators.maxWordsCount(3),
                              FormBuilderValidators.singleLine(),
                            ]),
                          ),
                          const SizedBox(height: 8),
                          Text('your email'.tr(), style: context.labelMedium).padVertical(10),
                          TextFormField(
                            autofocus: true,
                            controller: email,
                            validator: FormBuilderValidators.compose([FormBuilderValidators.required(), FormBuilderValidators.email()]),
                          ),
                          const SizedBox(height: 8),
                          Text('your password'.tr(), style: context.labelMedium).padVertical(10),
                          TextFormField(
                            autofocus: false,
                            controller: password,
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(),
                              FormBuilderValidators.password(
                                minLength: 6,
                                maxLength: 20,
                                minLowercaseCount: 0,
                                minNumberCount: 0,
                                minSpecialCharCount: 0,
                                minUppercaseCount: 0,
                              ),
                            ]),
                            obscureText: hidePassword.value,
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                onPressed: () {
                                  hidePassword.value == true ? hidePassword.value = false : hidePassword.value = true;
                                },
                                icon: hidePassword.value ? HugeIcon(icon: HugeIcons.strokeRoundedViewOff) : const HugeIcon(icon: HugeIcons.strokeRoundedView),
                              ),
                            ),
                          ),
                        ],
                      ),
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
                                        await ref
                                            .read(authNotifierProvider.notifier)
                                            .signup(name: name.text, email: email.text, password: password.text);
                                      }
                                    },
                              child: isLoading ? const BtnLoadingIndicatorComponent() : Text('sign up'.tr()),
                            );
                          },
                        ),
                      ).padOnly(top: 24),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
