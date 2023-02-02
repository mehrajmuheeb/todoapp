import 'package:base_flutter/data/models/notes/notes.dart';
import 'package:base_flutter/data/models/notes/notes_response.dart';
import 'package:base_flutter/data/models/user/user.dart';
import 'package:base_flutter/data/models/user/user_request.dart';

abstract class WebApi {
  Future<SignedUser> login();
  Future<String> createUser(UserRequest request);
  Future<SignedUser> userExists(String email);
  Future<bool> createNotes(Note note);
  Future<List<Notes>> getNotes();
  Future<bool> deleteNote(Notes note);
  Future<bool> updateNote(Notes note);

}
