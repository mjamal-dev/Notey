import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notey/app_colors.dart';
import 'package:notey/components/curved_box.dart';
import 'package:notey/components/date_footer.dart';

class NotePicCard extends StatelessWidget {
  const NotePicCard({
    Key? key,
    required this.w,
  }) : super(key: key);

  final double w;

  @override
  Widget build(BuildContext context) {
    return CurvedBox(
      padding: EdgeInsets.zero,
      children: [
        Container(
            height: 150,
            width: w,
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(25)),
            child: Image.asset(
              'assets/travel.jpg',
              fit: BoxFit.cover,
            )),
        const SizedBox(
          height: 16,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: const [
              Icon(
                CupertinoIcons.location,
                color: AppColors.lightGrey,
              ),
              SizedBox(
                width: 8,
              ),
              Text(
                'Kuta Beach',
                style: TextStyle(color: AppColors.lightGrey),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            'I stayed here for a big family vacation. This is a great affordable hotel to stay in Bali ...',
            style: TextStyle(color: AppColors.lightGrey),
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: DateFooter(date: 'Dec 24', footerText: 'Daily Life'),
        ),
        const SizedBox(
          height: 16,
        ),
      ],
    );
  }
}
