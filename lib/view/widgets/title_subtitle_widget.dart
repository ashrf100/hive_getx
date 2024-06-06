import 'package:flutter/material.dart';

class TitleSubtitleWidget extends StatelessWidget {
  final String? title;
  final String? subtitle;

  const TitleSubtitleWidget({
    this.title,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null) ...[
          Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: Text(
              title!,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
        ],
        if (subtitle != null) ...[
          Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: Text(
              subtitle!,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey.shade600,
              ),
            ),
          ),
        ],
      ],
    );
  }
}
