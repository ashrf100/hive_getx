import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart%20';

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
            padding: EdgeInsets.only(bottom: 4.h),
            child: Text(
              title!,
              style: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
        ],
        if (subtitle != null) ...[
          Padding(
            padding: EdgeInsets.only(bottom: 4.h),
            child: Text(
              subtitle!,
              style: TextStyle(
                fontSize: 16.sp,
                color: Colors.grey.shade600,
              ),
            ),
          ),
        ],
      ],
    );
  }
}
