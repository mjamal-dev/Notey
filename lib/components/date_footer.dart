import 'package:flutter/material.dart';
import 'package:notey/app_colors.dart';

class DateFooter extends StatelessWidget {
  const DateFooter({Key? key, required this.date, required this.footerText})
      : super(
          key: key,
        );
  final String date, footerText;
  final TextStyle style = const TextStyle(color: AppColors.lightGrey);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          date,
          style: style,
        ),
        Text(
          footerText,
          style: style,
        )
      ],
    );
  }
}
