import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../core/extensions/extensions.dart';
import 'svg_logo.dart';

class SplashScreenComponent extends StatelessWidget {
  const SplashScreenComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const Expanded(
              child: Center(
                child: SvgLogoComponent(width: 180),
              ),
            ),
            Center(
              child: CircularProgressIndicator.adaptive(),
            ),
            const SizedBox(height: 40),
            Text('copyright_splash', style: context.bodySmall,).tr(),
            const SizedBox(height: 60),
          ],
        ),
      ),
    );
  }
}