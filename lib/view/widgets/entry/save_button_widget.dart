import 'package:flutter/material.dart';

class SaveButtonWidget extends StatelessWidget {
  final VoidCallback? onPressed;
  final String buttonText;
  final IconData? icon; // Make icon optional
  final double? width;

  const SaveButtonWidget({
    Key? key,
    required this.onPressed,
    required this.buttonText,
    this.icon, // Update icon to be optional
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
        ),
        icon:
            icon != null ? Icon(icon) : null, // Only show icon if it's provided
        label: Text(
          buttonText,
          style: const TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
