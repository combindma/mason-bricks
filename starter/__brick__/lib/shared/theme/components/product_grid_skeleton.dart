import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ProductGridSkeletonComponent extends StatelessWidget {
  const ProductGridSkeletonComponent({super.key});

  @override
  Widget build(BuildContext context) {
    final darkMode = Theme.of(context).brightness == Brightness.dark;
    final baseColor = darkMode ? Colors.white10 : Colors.grey.shade200;
    final highlightColor = darkMode ? Colors.white12 : Colors.grey.shade100;

    return Column(
      spacing: 20,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          spacing: 10,
          children: [
            Expanded(
              child: Shimmer.fromColors(
                baseColor: baseColor,
                highlightColor: highlightColor,
                child: productCardSkeleton(darkMode),
              ),
            ),
            Expanded(
              child: Shimmer.fromColors(
                baseColor: baseColor,
                highlightColor: highlightColor,
                child: productCardSkeleton(darkMode),
              ),
            ),
          ],
        ),
        Row(
          spacing: 10,
          children: [
            Expanded(
              child: Shimmer.fromColors(
                baseColor: baseColor,
                highlightColor: highlightColor,
                child: productCardSkeleton(darkMode),
              ),
            ),
            Expanded(
              child: Shimmer.fromColors(
                baseColor: baseColor,
                highlightColor: highlightColor,
                child: productCardSkeleton(darkMode),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Column productCardSkeleton(bool darkMode) {
    return Column(
      spacing: 8,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 200,
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: darkMode ? Colors.grey.shade700 : Colors.grey.shade200,
              borderRadius: BorderRadius.circular(10.0), // Rounded corners
            ),
          ),
        ),
        Container(
          width: 100,
          height: 15,
          decoration: BoxDecoration(
            color: darkMode ? Colors.grey.shade700 : Colors.grey.shade200,
            borderRadius: BorderRadius.circular(50.0), // Rounded corners
          ),
        ),
        Container(
          height: 15,
          decoration: BoxDecoration(
            color: darkMode ? Colors.grey.shade700 : Colors.grey.shade200,
            borderRadius: BorderRadius.circular(50.0), // Rounded corners
          ),
        ),
        Container(
          width: 100,
          height: 15,
          decoration: BoxDecoration(
            color: darkMode ? Colors.grey.shade700 : Colors.grey.shade200,
            borderRadius: BorderRadius.circular(50.0), // Rounded corners
          ),
        ),
        Container(
          height: 15,
          decoration: BoxDecoration(
            color: darkMode ? Colors.grey.shade700 : Colors.grey.shade200,
            borderRadius: BorderRadius.circular(50.0), // Rounded corners
          ),
        ),
      ],
    );
  }
}
