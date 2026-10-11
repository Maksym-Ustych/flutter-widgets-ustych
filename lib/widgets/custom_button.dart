import 'package:flutter/material.dart';

enum CustomButtonStyle {
  primary,
  secondary,
  danger,
  outline,
}

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final CustomButtonStyle style;
  final IconData? icon;
  final bool isLoading;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.style = CustomButtonStyle.primary,
    this.icon,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    Color backgroundColor;
    Color foregroundColor;

    switch (style) {
      case CustomButtonStyle.primary:
        backgroundColor = theme.colorScheme.primary;
        foregroundColor = theme.colorScheme.onPrimary;
        break;
      case CustomButtonStyle.secondary:
        backgroundColor = theme.colorScheme.secondary;
        foregroundColor = theme.colorScheme.onSecondary;
        break;
      case CustomButtonStyle.danger:
        backgroundColor = Colors.red;
        foregroundColor = Colors.white;
        break;
      case CustomButtonStyle.outline:
        backgroundColor = Colors.transparent;
        foregroundColor = theme.colorScheme.primary;
        break;
    }

    final child = isLoading
        ? SizedBox(
            width: 22,
            height: 22,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: foregroundColor,
            ),
          )
        : Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icon != null) ...[
                Icon(icon),
                const SizedBox(width: 8),
              ],
              Text(text),
            ],
          );

    if (style == CustomButtonStyle.outline) {
      return OutlinedButton(
        onPressed: isLoading ? null : onPressed,
        child: child,
      );
    }

    return ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
      ),
      child: child,
    );
  }
}