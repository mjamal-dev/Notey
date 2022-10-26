import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class ToDoModel {
  final String title;
  final Map<String, bool> tasks;

  ToDoModel({required this.title, required this.tasks});

// Named constructor to return a ToDoModel by passing a Firestore's doc snapshot
  factory ToDoModel.fromSnapshot(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return ToDoModel(title: snapshot['title'], tasks: snapshot['tasks']);
  }

// Convert a todo list to a json string for storing it on Firestore collection
  Map<String, dynamic> toJson() => {"title": title, "tasks": tasks};
}
