import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class NoteModel {
  final String? title;
  final String? body;
  final String? id;
  final int? msSinceEpoch;
  var format = DateFormat("MMM d ,yy");

  NoteModel({
    this.title = "N/A",
    this.body = "N/A",
    this.id = "N/A",
    this.msSinceEpoch = 983394118,
  });

// Named constructor to return a NoteModel by passing the firestore's doc snapshot
  factory NoteModel.fromSnapshot(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return NoteModel(
        title: snapshot['title'],
        body: snapshot['body'],
        id: snapshot['id'],
        msSinceEpoch: snapshot['msSinceEpoch']);
  }

// Adding a toJson function to convert a note to json for firestore create
  Map<String, dynamic> toJson() =>
      {"title": title, "body": body, "id": id, "msSinceEpoch": msSinceEpoch};

  Set<String> readableDate() => {
        format
            .format(DateTime.fromMillisecondsSinceEpoch(msSinceEpoch!))
            .toString()
      };
}
