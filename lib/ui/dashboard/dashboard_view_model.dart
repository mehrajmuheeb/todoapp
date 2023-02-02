import 'dart:developer';

import 'package:base_flutter/base/base_view_model.dart';
import 'package:base_flutter/data/models/notes/notes.dart';
import 'package:base_flutter/data/models/notes/notes_response.dart';
import 'package:base_flutter/data/models/user/user.dart';
import 'package:base_flutter/firebase/firebase_instances.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'dashboard_navigator.dart';

class DashboardViewModel extends BaseViewModel<DashboardNavigator> {
  String imageUrl = "";
  SignedUser? user;
  List<Notes> notes = [];

  Future<void> addNotes(String message) async {
    webApi
        .createNotes(Note(message))
        .then((value) => onAddNoteSuccess(value))
        .onError((error, stackTrace) => onAddNoteError(error.toString()));
  }

  Future<void> setUserData() async {
    final user = await getProfile();
    this.user = user;
    notifyListeners();
  }

  onAddNoteSuccess(bool success) {
    getNavigator().onAddNoteSuccess();
  }

  onAddNoteError(String message) {
    getNavigator().onError(message);
  }

  void getNotes() {
    webApi
        .getNotes()
        .then((value) => onFetchNotesSuccess(value))
        .onError((error, stackTrace) => onFetchNotesError(error.toString()));
  }

  onFetchNotesSuccess(List<Notes> notes) {
    this.notes.clear();
    this.notes.addAll(notes);
    getNavigator().updateState();
    notifyListeners();
  }

  onFetchNotesError(String message) {
    print(message);
    getNavigator().updateState();
    getNavigator().onError(message);
  }

  void addNoteToOfflineList(String message) {
    var note = Notes(message: message, timestamp: DateTime.now().toString());
    notes.insert(0, note);
    notifyListeners();
  }


  void deleteNote(Notes note) {
    webApi.deleteNote(note).then((value) => onNoteDeleteSuccess())
        .onError((error, stackTrace) => onNoteDeleteError(error.toString()));
  }

  onNoteDeleteSuccess() {
    print("Note deleted");
  }

  onNoteDeleteError(String message) {
    print(message);    getNavigator().onError(message);
  }
}
