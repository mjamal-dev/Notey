import 'package:flutter/material.dart';
import 'package:notey/components/curved_box.dart';
import 'package:notey/components/date_footer.dart';
import 'package:notey/components/list_tile_row.dart';

class ReminderCard extends StatelessWidget {
  const ReminderCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CurvedBox(
      children: [
        Text(
          'Reminder',
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 8,
        ),
        const ListTileRow(isChecked: true, text: 'Exploration Design'),
        const ListTileRow(isChecked: true, text: 'Kuliah'),
        const ListTileRow(isChecked: false, text: 'Learn 3D model'),
        const ListTileRow(isChecked: false, text: 'Design Shots'),
        const SizedBox(
          height: 16,
        ),
        const DateFooter(date: 'Jan 17', footerText: 'ToDo')
      ],
    );
  }
}
