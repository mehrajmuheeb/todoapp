import 'package:base_flutter/data/models/notes/notes.dart';
import 'package:base_flutter/data/models/notes/notes_response.dart';
import 'package:base_flutter/data/models/user/user.dart';
import 'package:base_flutter/data/models/user/user_request.dart';
import 'package:base_flutter/data/network/api/web.dart';
import 'package:base_flutter/data/network/api_end_points.dart';
import 'package:base_flutter/data/network/api_response.dart';
import 'package:base_flutter/data/network/services/base_api_service.dart';
import 'package:base_flutter/data/network/services/db_service.dart';
import 'package:base_flutter/helpers/mixin/auth_mixin.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart';

class WebApiImpl with AuthMixin implements WebApi {
  final _dbService = DbService.dbInstance;

  @override
  Future<SignedUser> login() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    try {
      // Once signed in, return the UserCredential
      final result = await FirebaseAuth.instance
          .signInWithCredential(credential)
          .onError((error, stackTrace) => throw Exception(error.toString()));

      final userData = result.user;

      if (userData == null) {
        throw Exception("No user found");
      }

      final user = SignedUser(
          id: userData.uid ?? "0",
          name: userData.displayName ?? "Dummy name",
          email: userData.email ?? "Dummy email",
          image: userData.photoURL ?? "");

      return user;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<String> createUser(UserRequest user) async {
    try {
      final result = await _dbService
          .collection("users")
          .doc(user.email)
          .set(user.toMap())
          .then((value) => "Success");
      return result;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<SignedUser> userExists(String email) async {
    try {
      final result = await _dbService
          .collection("users")
          .where('email', isEqualTo: email)
          .get();

      if (result.docs.isEmpty) {
        throw Exception("User doesn't exist");
      }
      return SignedUser.fromJson(result.docs.first.data());
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> createNotes(Note note) async {
    final user = await getProfile();
    var isSuccess = false;
    if (user == null) throw Exception("User not found");
    final email = user.email;
    try {
      final checkTransaction = _dbService.collection("notes").doc(email);

      final result = await _dbService.runTransaction((transaction) async {
        final snapShot = await transaction.get(checkTransaction);
        if (snapShot.exists) {
          final snapShot =
              await _dbService.collection("notes").doc(email).update({
            "notes": FieldValue.arrayUnion([note.toJson()])
          }).onError((error, stackTrace) => () {
                    throw Exception(error.toString());
                  });
          return true;
        } else {
          final snapShot = await _dbService.collection("notes").doc(email).set({
            "notes": FieldValue.arrayUnion([note.toJson()])
          }, SetOptions(merge: false)).onError((error, stackTrace) => () {
                throw Exception(error.toString());
              });
          return true;
        }
      });
      return result;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<Notes>> getNotes() async {
    final user = await getProfile();
    if (user == null) throw Exception("User not found");
    final email = user.email;
    var notes = <Notes>[];

    final result = await _dbService.collection("notes").doc(email).get();
    if (result.exists) {
      var data = NotesResponse.fromJson(result.data()!);
      notes.addAll(data.notes ?? []);
    }
    return notes;
  }

  @override
  Future<bool> deleteNote(Notes note) async {
    final user = await getProfile();
    if (user == null) throw Exception("User not found");
    final email = user.email;
    final dbRef = _dbService.collection("notes").doc(email);

    final updates = <String, dynamic>{
      "notes": FieldValue.arrayRemove([note.toJson()])
    };

    try {
      final result = await dbRef
          .update(updates)
          .onError((error, stackTrace) => throw Exception(error.toString()));
      return true;
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }

  @override
  Future<bool> updateNote(Notes note) async {
    final user = await getProfile();
    if (user == null) throw Exception("User not found");
    final email = user.email;
    final dbRef = _dbService.collection("notes").doc(email);

    try {
      final result = await dbRef
          .get()
          .then((value) => findAndUpdate(value.data(), note))
          .onError((error, stackTrace) => throw Exception(error.toString()));
      return true;
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }

  findAndUpdate(Map<String, dynamic>? data, Notes note) {
    if(data == null) return;
    final result = NotesResponse.fromJson(data);
    if(result.notes == null) return;
    for(int i=0; i < result.notes!.length ; i++) {
      if(result.notes![i].timestamp == note.timestamp) {
        removeNote(result.notes![i], note);
        break;
      }
    }
  }

  Future<void> removeNote(Notes oldNote, Notes newNote) async {
    final user = await getProfile();
    if (user == null) throw Exception("User not found");
    final email = user.email;

    final result = await deleteNote(oldNote);

    final snapShot = await _dbService.collection("notes").doc(email).update({
      "notes": FieldValue.arrayUnion([newNote.toJson()])
    }).onError((error, stackTrace) => () {
      throw Exception(error.toString());
    });
  }
}
