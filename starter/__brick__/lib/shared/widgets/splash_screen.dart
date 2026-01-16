import 'package:flutter/material.dart';

import 'svg_logo.dart';

class SplashScreenComponent extends StatelessWidget {
  const SplashScreenComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          children: [
            const Expanded(
              child: Center(
                child: SvgLogoComponent(width: 180),
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: CircularProgressIndicator(color: Theme.of(context).colorScheme.onSurface),
            ),
            const SizedBox(height: 90),
          ],
        ),
      ),
    );
  }
}