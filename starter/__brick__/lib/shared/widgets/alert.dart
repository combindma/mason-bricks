import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AlertComponent extends StatelessWidget {
  const AlertComponent({super.key, required this.title, required this.message, this.action});

  final String title;
  final String message;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: <Widget>[
        TextButton(
          onPressed: () => context.pop(),
          child: const Text('Fermer'),
        ),
        if (action != null) action!,
      ],
    );
  }
}
