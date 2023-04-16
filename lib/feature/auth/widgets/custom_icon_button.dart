import 'package:flutter/material.dart';
import 'package:whatsapp_flutter/common/extension/custom_theme_extension.dart';

class CustomIconButton extends StatelessWidget {
  final VoidCallback onTap;
  final IconData iconData;
  final Color? color;
  final double? iconSize;
  final double? minWidth;
  final Color? background;
  final BoxBorder? border;

  const CustomIconButton({
    super.key,
    required this.onTap,
    required this.iconData,
    this.color,
    this.iconSize,
    this.minWidth,
    this.background,
    this.border,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: background, border: border, shape: BoxShape.circle),
      child: IconButton(
        onPressed: onTap,
        iconSize: 22,
        splashRadius: (minWidth ?? 45) - 25,
        splashColor: Colors.transparent,
        padding: EdgeInsets.zero,
        constraints: BoxConstraints(
          minWidth: (minWidth ?? 45),
          minHeight: (minWidth ?? 45),
        ),
        icon: Icon(
          iconData,
          color: color ?? Theme.of(context).appBarTheme.iconTheme!.color,
        ),
      ),
    );
  }
}
