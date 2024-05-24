import 'package:flutter/material.dart';

class TitleSubtitleWidget extends StatelessWidget {
  final String? title;
  final String? subtitle;

  TitleSubtitleWidget({
    this.title,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null) ...[
          Text(
            title!,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
        ],
        if (subtitle != null) ...[
          Text(
            subtitle!,
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
          SizedBox(height: 16),
        ],
      ],
    );
  }
}
