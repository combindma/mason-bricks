import 'package:flutter/material.dart';

import '../../../../shared/ui/skeleton.dart';

class ListTileAccountSkeleton extends StatelessWidget {
  const ListTileAccountSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      titleAlignment: ListTileTitleAlignment.center,
      title: Align(
        alignment: Alignment.centerLeft,
        child: SkeletonComponent(width: 120, height: 10),
      ),
      subtitle: SkeletonComponent(width: double.infinity, height: 8),
      onTap: () {},
    );
  }
}
