import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notey/app_colors.dart';
import 'package:notey/components/curved_box.dart';
import 'package:notey/components/date_footer.dart';

class DiaryCard extends StatelessWidget {
  const DiaryCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CurvedBox(
      children: [
        Text(
          'My Diary >,<',
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 30,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(
              CupertinoIcons.lock_fill,
              size: 55,
              color: AppColors.lightGrey,
            ),
          ],
        ),
        const SizedBox(
          height: 30,
        ),
        const DateFooter(date: 'Jan 21', footerText: 'My Targets')
      ],
    );
  }
}
