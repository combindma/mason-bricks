import 'package:flutter/material.dart';

class BtnLoadingIndicatorComponent extends StatelessWidget {
  const BtnLoadingIndicatorComponent({super.key, this.size = 20});

  final double size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CircularProgressIndicator(
        strokeWidth: 2,
        valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).colorScheme.onPrimary),
      ),
    );
  }
}
