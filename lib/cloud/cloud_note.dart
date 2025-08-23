import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterapp/cloud/clond_storage_constant.dart';
import 'package:flutter/widgets.dart';

@immutable
class CloudNote {
  final String documentId;
  final String ownerUserId;
  final String text;

  const CloudNote({
    required this.documentId,
    required this.ownerUserId,
    required this.text,
  });
  CloudNote.fromSnapshot(QueryDocumentSnapshot<Map<String, dynamic>> snapshot, {required String documentId})
    : documentId = snapshot.id,
      ownerUserId = snapshot.data()[ownerUserFieldName],
      text = snapshot.data()[textFieldName] as String;
}
