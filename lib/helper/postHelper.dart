import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreServices {
  final CollectionReference posts =
      FirebaseFirestore.instance.collection("Users");

// // Create
//   Future<void> addNotes(String note) {
//     return notes.add({
//       'note': note,
//       'timestamp': Timestamp.now(),
//     });
//   }

// Read

  Stream<QuerySnapshot> getPostsStream() {
    final postsStream =
        posts.orderBy('timestamp', descending: true).snapshots();
    return postsStream;
  }

// Update
//   Future<void> updateNote(String docID, String newNote) {
//     return notes
//         .doc(docID)
//         .update({'note': newNote, 'timestamp': Timestamp.now()});
//   }

// // Delete
//   Future<void> deleteNote(String docID) {
//     return notes.doc(docID).delete();
//   }
}
