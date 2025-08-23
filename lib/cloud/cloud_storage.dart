import 'package:flutter/widgets.dart';

@immutable
class CloudStorageException implements Exception {
  const CloudStorageException();
}

// C IN CRUN
class CloudNotCreateNoteException extends CloudStorageException {}

// R IN CRUN
class CloudNotGetAllNotesException extends CloudStorageException {}

// U IN CRUN
class CloudNotDeleteNoteException extends CloudStorageException {}

class CloudNotFindNoteException extends CloudStorageException {}

class CloudNotUpdateNoteException extends CloudStorageException {}

class UserShouldBeSetBeforeReading extends CloudStorageException {}
