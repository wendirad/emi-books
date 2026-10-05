import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../extensions/build_context_extensions.dart';

class Illustration extends StatelessWidget {
  final String assetName;
  final double? width;
  final double? height;
  final BoxFit fit;
  final String? semanticsLabel;
  final String? dartAssetName;

  const Illustration(
    this.assetName, {
    super.key,
    this.width,
    this.height,
    this.fit = BoxFit.contain,
    this.semanticsLabel,
    this.dartAssetName,
  });

  @override
  Widget build(BuildContext context) {
    final String name = context.isDark
        ? assetName
        : (dartAssetName ?? assetName);
    if (name.toLowerCase().endsWith('.svg')) {
      return SvgPicture.asset(
        name,
        width: width,
        height: height,
        fit: fit,
        semanticsLabel: semanticsLabel,
      );
    }
    return Image.asset(
      name,
      width: width,
      height: height,
      fit: fit,
      semanticLabel: semanticsLabel,
    );
  }
}
