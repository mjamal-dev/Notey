import 'package:flutter/material.dart';
import 'package:notey/components/curved_box.dart';
import 'package:notey/components/date_footer.dart';

class QuoteCard extends StatelessWidget {
  const QuoteCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CurvedBox(
      children: [
        Text(
          'Quote today',
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 8,
        ),
        const Text(
            '''"The best preparation for tomorrow is doing your best today"\n- H. Jackson Jr.'''),
        const SizedBox(
          height: 16,
        ),
        const DateFooter(date: 'Jan 21', footerText: 'Quote')
      ],
    );
  }
}
