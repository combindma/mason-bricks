import 'package:country_picker/country_picker.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../../../core/extensions/extensions.dart';
import '../../../../shared/theme/spacing.dart';
import '../controllers/user_controller.dart';
import '../widgets/delete_account_dialog.dart';

class EditProfileScreen extends HookConsumerWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useMemoized(() => GlobalKey<FormState>());
    final name = useTextEditingController();
    final phone = useTextEditingController();
    final address = useTextEditingController();
    final city = useTextEditingController();
    final zipCode = useTextEditingController();
    final country = useTextEditingController();
    final userController = ref.watch(userControllerProvider);
    final isKeyboardVisible = context.viewInsets.bottom > 0;

    return Scaffold(
      backgroundColor: context.isDarkMode ? Colors.grey.shade900 : Colors.grey.shade100,
      appBar: AppBar(title: Text('edit profile'.tr())),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            if (userController.isLoading) {
              return const Center(child: CircularProgressIndicator.adaptive());
            }
            if (userController.error != null) {
              return SizedBox.shrink();
            }

            name.text = userController.requireValue?.name ?? '';
            phone.text = userController.requireValue?.phone ?? '';
            address.text = userController.requireValue?.address ?? '';
            city.text = userController.requireValue?.city ?? '';
            zipCode.text = userController.requireValue?.zipCode ?? '';
            country.text = userController.requireValue?.country ?? '';

            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: BaseSpacing.containerPadding, vertical: BaseSpacing.defaultSpace),
              child: Form(
                key: formKey,
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight - BaseSpacing.defaultSpace * 2),
                  child: Column(
                    mainAxisAlignment: .start,
                    crossAxisAlignment: .start,
                    children: [
                      Text('your name'.tr(), style: context.labelMedium).padVertical(6),
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
                      Text('your phone', style: context.labelMedium).tr().padVertical(6),
                      TextFormField(
                        controller: phone,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return null;
                          }
                          return FormBuilderValidators.phoneNumber()(value);
                        },
                      ),
                      const SizedBox(height: 8),
                      Text('address', style: context.labelMedium).tr().padVertical(6),
                      TextFormField(
                        controller: address,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return null;
                          }
                          return FormBuilderValidators.maxWordsCount(20)(value);
                        },
                      ),
                      const SizedBox(height: 8),
                      Row(
                        crossAxisAlignment: .start,
                        spacing: 8,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: .start,
                              children: [
                                Text('city', style: context.labelMedium).tr().padVertical(6),
                                TextFormField(
                                  controller: city,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return null;
                                    }
                                    return FormBuilderValidators.maxWordsCount(20)(value);
                                  },
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: .start,
                              children: [
                                Text('zip code', style: context.labelMedium).tr().padVertical(6),
                                TextFormField(
                                  controller: zipCode,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return null;
                                    }
                                    return FormBuilderValidators.zipCode()(value);
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text('country', style: context.labelMedium).tr().padVertical(6),
                      TextFormField(
                        controller: country,
                        readOnly: true,
                        validator: FormBuilderValidators.compose([FormBuilderValidators.required()]),
                        onTap: () {
                          showCountryPicker(
                            context: context,
                            showPhoneCode: false,
                            onSelect: (Country c) {
                              country.text = c.name;
                            },
                            countryListTheme: CountryListThemeData(
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0)),
                              inputDecoration: InputDecoration(
                                hintText: 'search country'.tr(),
                                prefixIcon: const Icon(Icons.search),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 24),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              await ref
                                  .read(userControllerProvider.notifier)
                                  .updateProfile(
                                    name: name.text.trim(),
                                    phone: phone.text.trim(),
                                    address: address.text.trim(),
                                    city: city.text.trim(),
                                    zipCode: zipCode.text.trim(),
                                    country: country.text.trim(),
                                  );
                            }
                          },
                          child: Text('update profile'.tr()),
                        ),
                      ),
                      const SizedBox(height: 40),
                      Visibility(
                        visible: !isKeyboardVisible,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('account actions'.tr(), style: context.bodyMedium),
                            TextButton(
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.zero,
                                tapTargetSize: MaterialTapTargetSize.padded,
                                overlayColor: Colors.transparent,
                              ),
                              onPressed: () async => await showAdaptiveDialog(context: context, builder: (_) => DeleteAccountDialog()),
                              child: Row(
                                children: [
                                  HugeIcon(icon: HugeIcons.strokeRoundedDelete02, color: Colors.red, size: 20),
                                  SizedBox(width: 10),
                                  Text('delete account'.tr()).medium.withColor(Colors.red),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
