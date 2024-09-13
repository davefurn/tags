import 'package:flutter/material.dart';
import 'package:tags/src/core/constant/colors.dart';

class ToggleButton extends StatelessWidget {
  const ToggleButton({
    required this.isSelected,
    required this.onPressed,
    super.key,
    this.iconPath,
    this.icon,
  });
  final bool isSelected;
  final VoidCallback onPressed;
  final String? iconPath;
  final IconData? icon;

  @override
  Widget build(BuildContext context) => IconButton(
        onPressed: onPressed,
        icon: CircleAvatar(
          backgroundColor: isSelected ? TagColors.paleBlue : Colors.transparent,
          child: iconPath != null
              ? Image.asset(iconPath!, height: 14)
              : Icon(icon, size: 24),
        ),
      );
}
