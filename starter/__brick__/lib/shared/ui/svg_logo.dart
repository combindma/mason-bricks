import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../config/app_config.dart';
import '../theme/logos.dart';

class SvgLogoComponent extends StatelessWidget {
  const SvgLogoComponent({
    super.key,
    this.width = 90,
  });

  final double width;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      BaseLogos.svgLogo,
      semanticsLabel: 'Logo ${AppConfig.name}',
      width: width,
      colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.onSurface, BlendMode.srcIn),
    );
  }
}
