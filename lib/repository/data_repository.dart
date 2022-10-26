import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:notey/models/note_model.dart';

class DataRepository {
// helper function to read notes/secure_notes from firebase firestore

  static Stream<List<NoteModel>>? readNotes({bool secure = false}) {
    final noteType = secure ? 'secure_notes' : 'notes';
    final noteCollection = FirebaseFirestore.instance.collection(noteType);
    return noteCollection.snapshots().map(
        (query) => query.docs.map((e) => NoteModel.fromSnapshot(e)).toList());
  }

  // static Stream<List<ToDoModel>>? readTodo(bool secure) {
  //   final todoCollection = FirebaseFirestore.instance.collection('todo');
  //   return todoCollection.snapshots().map(
  //       (query) => query.docs.map((e) => ToDoModel.fromSnapshot(e)).toList());
  // }

// A helper function that receives a NoteModel as an arg
//to create a note on the Firestore collection 'notes'

  static Future createNote(
      {required NoteModel note, bool secure = false}) async {
    final noteType = secure ? 'secure_notes' : 'notes';
    final noteCollection = FirebaseFirestore.instance.collection(noteType);
    final nid = noteCollection.doc().id;
    final docRef = noteCollection.doc(nid);

    try {
      await docRef.set(NoteModel(
              title: note.title,
              body: note.body,
              id: nid,
              msSinceEpoch: DateTime.now().millisecondsSinceEpoch)
          .toJson());
    } catch (e) {
      print('Some error occurred in creating a new note $e');
    }
  }

// Helper function that updates a given note based on note id
  static Future updateNote(
      {required NoteModel note, bool secure = false}) async {
    final noteType = secure ? 'secure_notes' : 'notes';
    final noteCollection = FirebaseFirestore.instance.collection(noteType);
    final docRef = noteCollection.doc(note.id);

    try {
      await docRef.update(NoteModel(
              title: note.title,
              body: note.body,
              id: note.id,
              msSinceEpoch: DateTime.now().millisecondsSinceEpoch)
          .toJson());
    } catch (e) {
      print('Some error occurred in creating a new note $e');
    }
  }

// Helper function that deletes a note on Firestore based on given note id
  static Future deleteNote(
      {required NoteModel note, bool secure = false}) async {
    final noteType = secure ? 'secure_notes' : 'notes';
    final noteCollection = FirebaseFirestore.instance.collection(noteType);
    final docRef = noteCollection.doc(note.id);

    try {
      await docRef.delete();
    } catch (e) {
      print('Some error occurred in deleting a note $e');
    }
  }

// A helper function that receives a NoteModel as an arg
//to create a note on the Firestore collection 'notes'

//   Future createToDo(ToDoModel todo) async {
//     final todoCollection = FirebaseFirestore.instance.collection('todo');
//     final docRef = todoCollection.doc();

//     try {
//       await docRef
//           .set(ToDoModel(title: todo.title, tasks: todo.tasks).toJson());
//     } catch (e) {
//       print('Some error has occurred in creating a new todo $e');
//     }
//   }
}
