import 'dart:developer';

import 'package:base_flutter/base/base_view_model.dart';
import 'package:base_flutter/data/models/notes/notes.dart';
import 'package:base_flutter/data/models/notes/notes_response.dart';
import 'package:base_flutter/data/models/user/user.dart';
import 'package:base_flutter/firebase/firebase_instances.dart';
import 'package:base_flutter/helpers/formatter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import 'dashboard_navigator.dart';

class DashboardViewModel extends BaseViewModel<DashboardNavigator> {
  String imageUrl = "";
  SignedUser? user;
  String? selectedDate;
  List<Notes> notes = [];
  List<Notes> fetchedNotes = [];

  Future<void> setUserData() async {
    final user = await getProfile();
    this.user = user;
    selectedDate = getDate(DateTime.now());
    notifyListeners();
  }


  void getNotes() {
    webApi
        .getNotes()
        .then((value) => onFetchNotesSuccess(value))
        .onError((error, stackTrace) => onFetchNotesError(error.toString()));
  }

  onFetchNotesSuccess(List<Notes> notes) {
    fetchedNotes.clear();
    fetchedNotes = notes;
    filterNotes();
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
    print(message);
    getNavigator().onError(message);
  }

  void filterNotes() {
    final filteredNotes = <Notes>[];
    notes.clear();
    notifyListeners();
    if (kDebugMode) {
      print("Date: ${selectedDate.toString()}");
    }
    for (var note in fetchedNotes) {
      print("Notes: ${note.toJson()}");
      if(selectedDate == note.date) {
        filteredNotes.add(note);
      }
    }
    notes = filteredNotes;
    getNavigator().updateState();
  }
}
