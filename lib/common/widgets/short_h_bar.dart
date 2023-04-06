import 'package:flutter/material.dart';
import 'package:whatsapp_flutter/common/extension/custom_theme_extension.dart';

class ShortHBar extends StatelessWidget {
  const ShortHBar({super.key, this.height, this.width, this.color});

  final double? height;
  final double? width;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? 25,
      height: height ?? 4,
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        color: color ?? context.theme.greyColor!.withOpacity(.2),
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }
}
