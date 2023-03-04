import 'package:flutter/material.dart';
import 'package:whatsapp_flutter/common/extension/custom_theme_extension.dart';

class CustomIconButton extends StatelessWidget {
  final VoidCallback onTap;
  final IconData iconData;
  final Color? color;
  final double? iconSize;
  final double? minWidth;

  const CustomIconButton({
    super.key,
    required this.onTap,
    required this.iconData,
    this.color,
    this.iconSize,
    this.minWidth,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {},
      iconSize: 22,
      splashRadius: 22,
      splashColor: Colors.transparent,
      padding: EdgeInsets.zero,
      constraints: BoxConstraints(
        minWidth: minWidth ?? 40,
      ),
      icon: Icon(
        iconData,
        color: color ?? context.theme.greyColor,
      ),
    );
  }
}
