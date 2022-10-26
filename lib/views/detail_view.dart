import 'package:flutter/material.dart';
import 'package:notey/app_colors.dart';
import 'package:notey/models/note_model.dart';
import 'package:notey/repository/data_repository.dart';

class CardDetailPage extends StatefulWidget {
  final NoteModel note;
  final bool secured;

  const CardDetailPage({Key? key, required this.note, this.secured = false})
      : super(key: key);
  @override
  _CardDetailPageState createState() => _CardDetailPageState();
}

class _CardDetailPageState extends State<CardDetailPage> {
  late TextEditingController _titleController;
  late TextEditingController _bodyController;
  @override
  void initState() {
    _titleController = TextEditingController();
    _bodyController = TextEditingController();
    super.initState();
    setState(() {
      if (widget.note.title != "N/A" && widget.note.body != "N/A") {
        _titleController.text = widget.note.title!;
        _bodyController.text = widget.note.body!;
      }
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    _bodyController.dispose();
    super.dispose();
  }

  void onBack() {
    if (widget.note.title! != "N/A" && widget.note.body! != "N/A") {
      if (widget.note.title! != _titleController.text ||
          widget.note.body! != _bodyController.text) {
        DataRepository.updateNote(
            note: NoteModel(
                title: _titleController.text,
                body: _bodyController.text,
                id: widget.note.id),
            secure: widget.secured);
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Note has been updated')));
      }
    } else if (_titleController.text == '' && _bodyController.text == '') {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Empty note has been discarded')));
    } else {
      DataRepository.createNote(
          note: NoteModel(
              title: _titleController.text, body: _bodyController.text),
          secure: widget.secured);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Added a new note!'),
      ));
    }
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: (() async {
        onBack();
        return false;
      }),
      child: Scaffold(
        backgroundColor: AppColors.scaffoldBackground,
        appBar: AppBar(
          backgroundColor: AppColors.scaffoldBackground,
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              onBack();
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              size: 22,
              color: Colors.white.withOpacity(0.7),
            ),
          ),
          actions: [
            IconButton(
              onPressed: null,
              icon: Icon(
                Icons.pin,
                color: Colors.white.withOpacity(0.7),
                size: 22,
              ),
            ),
            IconButton(
              onPressed: null,
              icon: Icon(
                Icons.notifications,
                color: Colors.white.withOpacity(0.7),
                size: 22,
              ),
            ),
            IconButton(
              onPressed: null,
              icon: Icon(
                Icons.archive,
                color: Colors.white.withOpacity(0.7),
                size: 22,
              ),
            )
          ],
        ),
        body: getBody(),
        bottomSheet: getFooter(),
      ),
    );
  }

  Widget getBody() {
    return ListView(
      padding: EdgeInsets.only(top: 25, right: 15, bottom: 25, left: 15),
      children: [
        TextField(
          controller: _titleController,
          style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 22,
              color: Colors.white.withOpacity(0.8)),
          decoration: const InputDecoration(
              border: InputBorder.none, hintText: 'Title'),
        ),
        TextField(
          maxLines: 10,
          controller: _bodyController,
          style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 14,
              height: 1.5,
              color: Colors.white.withOpacity(0.8)),
          decoration:
              InputDecoration(border: InputBorder.none, hintText: 'Note'),
        ),
        // widget.img.length > 0
        //     ? Column(
        //         children: [
        //           Row(
        //               children: List.generate(widget.img.length, (index) {
        //             return Padding(
        //               padding: const EdgeInsets.only(right: 5),
        //               child: Container(
        //                 width: 25,
        //                 height: 25,
        //                 decoration: BoxDecoration(
        //                     shape: BoxShape.circle,
        //                     border: Border.all(
        //                         color: Colors.white.withOpacity(0.1)),
        //                     image: DecorationImage(
        //                         image: NetworkImage(widget.img[index]),
        //                         fit: BoxFit.cover)),
        //               ),
        //             );
        //           }))
        //         ],
        //       )
        Container()
      ],
    );
  }

  Widget getFooter() {
    var size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: 80,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 3)
        ],
        color: AppColors.cardColor,
      ),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 25, right: 10, left: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () {
                DataRepository.deleteNote(
                    note: widget.note, secure: widget.secured);
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text('Note moved to trash!'),
                  action: SnackBarAction(
                      textColor: Colors.blueAccent,
                      label: 'Undo',
                      onPressed: () {
                        DataRepository.createNote(
                            note: NoteModel(
                                title: widget.note.title,
                                body: widget.note.body),
                            secure: widget.secured);
                      }),
                ));
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.delete_rounded,
                size: 22,
                color: Colors.redAccent.shade200.withOpacity(0.7),
              ),
            ),
            Text(
              "Edited ${widget.note.readableDate().first}",
              style:
                  TextStyle(fontSize: 12, color: Colors.white.withOpacity(0.7)),
            ),
            IconButton(
              onPressed: null,
              icon: Icon(
                Icons.more_vert,
                size: 22,
                color: Colors.white.withOpacity(0.7),
              ),
            )
          ],
        ),
      ),
    );
  }
}
