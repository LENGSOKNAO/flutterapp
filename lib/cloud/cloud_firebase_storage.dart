import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterapp/cloud/clond_storage_constant.dart';
import 'package:flutterapp/cloud/cloud_note.dart';
import 'package:flutterapp/cloud/cloud_storage.dart';

class CloudFirebaseStorage {
  final notes = FirebaseFirestore.instance.collection('users');

  Future<void> deleteNote({required String documentId}) async {
    await notes.doc(documentId).delete();
  }

  Future<void> deleteByNote({required String documentId}) async {
    try {
      await notes.doc(documentId).delete();
    } catch (e) {
      throw CloudNotDeleteNoteException();
    }
  }

  Future<void> updateNote({
    required String documentId,
    required String newText,
  }) async {
    try {
      await notes.doc(documentId).update({textFieldName: newText});
    } catch (e) {
      throw CloudNotUpdateNoteException();
    }
  }

  Stream<Iterable<CloudNote>> getAllNote({required String ownerUserId}) =>
      notes.snapshots().map(
        (event) => event.docs
            .map((doc) => CloudNote.fromSnapshot(doc, documentId: doc.id))
            .where((note) => note.ownerUserId == ownerUserId),
      );

  Future<Iterable<CloudNote>> getNotes({required String ownerUserId}) async {
    try {
      return await notes
          .where(ownerUserFieldName, isEqualTo: ownerUserId)
          .get()
          .then((snapshot) {
            return snapshot.docs.map(
              (doc) => CloudNote(
                documentId: doc.id,
                ownerUserId: doc.data()[ownerUserFieldName] as String,
                text: doc.data()[textFieldName] as String,
              ),
            );
          });
    } catch (e) {
      throw CloudNotGetAllNotesException();
    }
  }

  void createNewNote({required String ownerUserId}) async {
    await notes.add({ownerUserFieldName: ownerUserId, textFieldName: ''});
  }

  static final CloudFirebaseStorage _shared =
      CloudFirebaseStorage._sharedInstance();

  CloudFirebaseStorage._sharedInstance();
  factory CloudFirebaseStorage() => _shared;
}
