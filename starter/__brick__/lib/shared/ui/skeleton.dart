import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../core/extensions/extensions.dart';

class SkeletonComponent extends StatelessWidget {
  const SkeletonComponent({super.key, required this.width, required this.height});

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: context.isDarkMode ? Colors.grey.shade700 : Colors.grey.shade300,
      highlightColor: context.isDarkMode ? Colors.grey.shade500 : Colors.grey.shade200,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: context.isDarkMode ? Colors.grey.shade700 : Colors.grey.shade200,
          borderRadius: BorderRadius.circular(24.0),
        ),
      ),
    );
  }
}
