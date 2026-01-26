import 'package:flutter/material.dart';

import '../../core/extensions/extensions.dart';

class SectionDivider extends StatelessWidget {
  const SectionDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Divider(height: 5, color: context.isDarkMode ? Colors.grey.shade800 : Colors.grey.shade200, thickness: 2);
  }
}
