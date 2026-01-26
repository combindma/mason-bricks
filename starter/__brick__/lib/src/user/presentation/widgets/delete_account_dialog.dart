import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/extensions/extensions.dart';
import '../../../../routes/routes.dart';

class DeleteAccountDialog extends StatelessWidget {
  const DeleteAccountDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog.adaptive(
      actionsAlignment: MainAxisAlignment.end,
      title: Text('delete account'.tr()),
      content: Text('delete_account.title'.tr(), style: context.bodyLarge),
      actions: [
        TextButton(child: Text('delete_account.cancel'.tr()).medium, onPressed: () => Navigator.of(context).pop()),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            context.pushNamed(Routes.deleteAccount.name);
          },
          style: TextButton.styleFrom(foregroundColor: Colors.red),
          child: Text('delete_account.confirm'.tr()).medium,
        ),
      ],
    );
  }
}
