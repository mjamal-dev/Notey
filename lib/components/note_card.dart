import 'package:flutter/material.dart';
import 'package:notey/app_colors.dart';
import 'package:notey/models/note_model.dart';
import 'package:notey/views/detail_view.dart';

// class NoteCard extends StatelessWidget {
//   NoteCard({
//     Key? key,
//     required this.note,
//   }) : super(key: key);

//   final NoteModel? note;

//   @override
//   Widget build(BuildContext context) {
//     var format = DateFormat("MMM d ,yy");
//     return CurvedBox(
//       children: [
//         Text(
//           note!.title,
//           style: Theme.of(context)
//               .textTheme
//               .titleLarge!
//               .copyWith(fontWeight: FontWeight.bold),
//         ),
//         const SizedBox(
//           height: 8,
//         ),
//         Text(note!.body),
//         const SizedBox(
//           height: 16,
//         ),
//         DateFooter(
//             date: format
//                 .format(DateTime.fromMillisecondsSinceEpoch(1666307357982)),
//             footerText: 'My Targets')
//       ],
//     );
//   }
// }

class NoteCard extends StatefulWidget {
  final NoteModel note;
  final secured;

  const NoteCard({Key? key, required this.note, this.secured = false})
      : super(key: key);

  @override
  _NoteCardState createState() => _NoteCardState();
}

class _NoteCardState extends State<NoteCard> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: ((context) => CardDetailPage(
                      note: widget.note,
                      secured: widget.secured,
                    ))));
      },
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: size.height * 0.015, vertical: size.width * 0.015),
        child: Container(
          height: size.height * 0.2,
          width: size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: AppColors.containerBackground,
            border: Border.all(color: Colors.white.withOpacity(0.1)),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
                vertical: size.height * 0.015, horizontal: size.width * 0.02),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.note.title!,
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.white.withOpacity(0.9),
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: size.height * 0.01,
                ),
                Text(widget.note.body!,
                    style: TextStyle(
                        fontSize: 13,
                        height: 1.5,
                        color: Colors.white.withOpacity(0.7),
                        fontWeight: FontWeight.w400)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
