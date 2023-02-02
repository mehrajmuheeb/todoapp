import 'dart:developer';

import 'package:base_flutter/base/base_view_model.dart';
import 'package:base_flutter/data/models/notes/notes_response.dart';
import 'package:base_flutter/ui/notes/notes_navigator.dart';

class NotesViewModel extends BaseViewModel<NotesNavigator> {
  String message = "";
  Notes? note;
  void createOrUpdate() {
    if(note == null) {
      _createNote();
    } else {
      _updateNote();
    }
  }

  void _createNote() {

  }

  void _updateNote() {
    if(note == null) return;
    note?.message = message;

    webApi.updateNote(note!)
    .then((value) => _onUpdateNoteSuccess(value))
    .onError((error, stackTrace) => _onUpdateNoteError(error.toString()));

  }

  _onUpdateNoteSuccess(bool success) {

  }

  _onUpdateNoteError(String message) {

  }
}
