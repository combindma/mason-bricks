import 'package:flutter/material.dart';

class CarouselLayoutComponent extends StatelessWidget {
  const CarouselLayoutComponent({super.key, required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 350,
      child: CarouselView(
        backgroundColor: Colors.transparent,
        scrollDirection: Axis.horizontal,
        itemExtent: 170,
        shrinkExtent: 170,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
        ),
        children: children,
      ),
    );
  }
}
