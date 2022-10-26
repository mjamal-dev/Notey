import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:notey/app_colors.dart';
import 'package:notey/components/note_card.dart';
import 'package:notey/models/note_model.dart';
import 'package:notey/repository/data_repository.dart';
import 'package:notey/views/detail_view.dart';

class AllView extends StatefulWidget {
  const AllView({Key? key}) : super(key: key);

  @override
  State<AllView> createState() => _AllViewState();
}

class _AllViewState extends State<AllView> with SingleTickerProviderStateMixin {
  late Animation<double> _animation;
  late AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 260),
    );

    final curvedAnimation =
        CurvedAnimation(curve: Curves.easeInOut, parent: _animationController);
    _animation = Tween<double>(begin: 0, end: 1).animate(curvedAnimation);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (() {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: ((context) => CardDetailPage(note: NoteModel())),
              ));
        }),
        child: const Icon(
          Icons.add,
          color: AppColors.scaffoldBackground,
        ),
      ),

      // body
      body: StreamBuilder<List<NoteModel>>(
          stream: DataRepository.readNotes(secure: false),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Text('Some error has occurred ${snapshot.error}');
            } else if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              List<NoteModel>? notes = snapshot.data;

              return ListView.builder(
                  itemCount: notes!.length,
                  itemBuilder: ((context, index) {
                    return FadeInLeft(
                      duration: Duration(milliseconds: index * 350),
                      child: NoteCard(note: notes[index]),
                    );
                  }));
            }
          }),

      // StreamBuilder<List<NoteModel>>(
      //     stream: DataRepository.readNotes(),
      //     builder: (context, snapshot) {
      //       if (!snapshot.hasData) {
      //         return const Center(
      //           child: CircularProgressIndicator(),
      //         );
      //       } else {
      //         List<NoteModel>? notes = snapshot.data;

      //         return AnimationLimiter(
      //           child: MasonryGridView.count(
      //               padding: const EdgeInsets.all(16),
      //               crossAxisCount: 2,
      //               mainAxisSpacing: 16,
      //               crossAxisSpacing: 16,
      //               itemCount: notes!.length,
      //               itemBuilder: (context, i) {
      //                 return AnimationConfiguration.staggeredGrid(
      //                     position: i,
      //                     columnCount: 2,
      //                     child: ScaleAnimation(
      //                       child: FadeInAnimation(
      //                         child: NoteCard(note: notes[i]),
      //                         // child: i == 0
      //                         //     ? ReminderCard()
      //                         //     : i == 1
      //                         //         ? QuoteCard()
      //                         //         : i == 2
      //                         //             ? NotePicCard(w: w)
      //                         //             : i == 4
      //                         //                 ? NoteCard(note: notes![i])
      //                         //                 : i == 5
      //                         //                     ? DiaryCard()
      //                         //                     : const SizedBox.shrink(),
      //                       ),
      //                     ));
      //               }),
      //         );
      //       }
      //     }),
    );
  }
}
