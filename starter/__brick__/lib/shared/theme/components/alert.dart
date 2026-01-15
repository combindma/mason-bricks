import 'package:flutter/material.dart';

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
          onPressed: () => Navigator.pop(context, 'Fermer'),
          child: const Text('Fermer'),
        ),
        if (action != null) action!,
      ],
    );
  }
}
