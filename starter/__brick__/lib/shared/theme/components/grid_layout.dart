import 'package:flutter/material.dart';

class GridLayoutComponent extends StatelessWidget {
  const GridLayoutComponent({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
    this.crossAxisCount = 2,
    this.aspectRatio = 16 / 9,
    this.mainAxisExtent,
    this.mainAxisSpacing = 5,
    this.crossAxisSpacing = 5,
    this.physics = const NeverScrollableScrollPhysics(),
  });

  final int itemCount;
  final double aspectRatio;
  final double? mainAxisExtent;
  final int crossAxisCount;
  final double mainAxisSpacing;
  final double crossAxisSpacing;
  final Widget? Function(BuildContext, int) itemBuilder;
  final ScrollPhysics? physics;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: itemCount,
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      physics: physics,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        childAspectRatio: aspectRatio,
        mainAxisSpacing: mainAxisSpacing,
        crossAxisSpacing: crossAxisSpacing,
        mainAxisExtent: mainAxisExtent,
      ),
      itemBuilder: itemBuilder,
    );
  }
}
