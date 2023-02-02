import 'dart:developer';

import 'package:base_flutter/base/base_view_model.dart';
import 'package:base_flutter/data/models/notes/notes.dart';
import 'package:base_flutter/data/models/notes/notes_response.dart';
import 'package:base_flutter/helpers/formatter.dart';
import 'package:base_flutter/ui/notes/notes_navigator.dart';

class NotesViewModel extends BaseViewModel<NotesNavigator> {
  String message = "";
  String selectedDate = getDate(DateTime.now());
  Notes? note;
  void createOrUpdate() {
    if(note == null) {
      _createNote();
    } else {
      _updateNote();
    }
  }

  Future<void> _createNote() async {
    webApi
        .createNotes(Note(message, selectedDate))
        .then((value) => onAddNoteSuccess(value))
        .onError((error, stackTrace) => onAddNoteError(error.toString()));
  }

  onAddNoteSuccess(bool value) {
    getNavigator().onAddNotesSuccess();
  }

  onAddNoteError(String message) {
    getNavigator().onError(message);
  }

  void _updateNote() {
    if(note == null) return;
    note?.message = message;

    webApi.updateNote(note!)
    .then((value) => _onUpdateNoteSuccess(value))
    .onError((error, stackTrace) => _onUpdateNoteError(error.toString()));

  }

  _onUpdateNoteSuccess(bool success) {
    getNavigator().onAddNotesSuccess();
  }

  _onUpdateNoteError(String message) {
    getNavigator().onError(message);
  }

  void updateSelectDate(String date) {
    selectedDate = date;
    notifyListeners();
  }
}
