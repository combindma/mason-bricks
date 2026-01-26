import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../core/extensions/extensions.dart';

class BtnLoadingIndicatorComponent extends StatelessWidget {
  const BtnLoadingIndicatorComponent({super.key, this.size = 20, this.isDestructive = false});

  final double size;
  final bool isDestructive;


  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return SizedBox(
        width: size,
        height: size,
        child: CupertinoActivityIndicator(
          color: isDestructive ? Colors.white : context.colorScheme.onPrimary,
        ),
      );
    }
    return SizedBox(
      width: size,
      height: size,
      child: CircularProgressIndicator(
        color: isDestructive ? Colors.white : context.colorScheme.onPrimary,
      ),
    );
  }
}
