import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
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
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onPressed: onPressed,
        icon: CircleAvatar(
          backgroundColor: isSelected ? TagColors.paleBlue : Colors.transparent,
          child: iconPath != null
              ? Image.asset(iconPath!, height: 14)
              : Icon(icon, size: 24),
        ),
      );
}

class ViewToggleNotifier extends StateNotifier<bool> {
  ViewToggleNotifier() : super(false); // Default view is list (not grid)

  void toggleView(bool grid) {
    state = grid;
  }

  void toggle() {
    state = !state; // Toggle between grid and list views
  }
}

// Creating a provider for ViewToggleNotifier
final viewToggleProvider = StateNotifierProvider<ViewToggleNotifier, bool>(
  (ref) => ViewToggleNotifier(),
);
