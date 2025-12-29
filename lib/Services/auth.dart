import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

/// Handles Google Sign-In and exposes the current user to the app using Provider.
class GoogleSignInProvider extends ChangeNotifier {
  final googleSignIn = GoogleSignIn();
  GoogleSignInAccount? _user;
  GoogleSignInAccount get user => _user!;

  /// Check if the user already exists in Firestore.
  Future<bool> doesUserExist() async {
    final snapshot = await FirebaseFirestore.instance
        .collection('Data')
        .where("Email", isEqualTo: FirebaseAuth.instance.currentUser!.email)
        .get();
    return snapshot.docs.isNotEmpty;
  }

  /// Initialize the user's data in Firestore if it's their first time logging in.
  Future<void> startCollection() async {
    bool condition = await doesUserExist();
    if (condition == false) {
      FirebaseFirestore.instance
          .collection("Data")
          .doc(
        FirebaseAuth.instance.currentUser!.uid,
      )
          .set({
        "Email": FirebaseAuth.instance.currentUser!.email,
        "WatchList": [],
      });
    }
  }

  /// Trigger the Google Sign-In flow and then sign in to Firebase with the credential.
  Future googleLogin() async {
    final googleUser = await googleSignIn.signIn();
    if (googleUser == null) return;
    _user = googleUser;
    final googleAuth = await googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    await FirebaseAuth.instance.signInWithCredential(credential).then((value) {
      startCollection();
    });
    notifyListeners();
  }

  /// Silent sign-in (for biometric auth) - attempts to sign in without UI
  Future<bool> silentSignIn() async {
    try {
      final googleUser = await googleSignIn.signInSilently();
      if (googleUser == null) return false;

      _user = googleUser;
      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);
      notifyListeners();
      return true;
    } catch (e) {
      print('Silent sign-in failed: $e');
      return false;
    }
  }

  /// Log the user out of both Google and Firebase.
  Future logout() async {
    await googleSignIn.signOut();
    FirebaseAuth.instance.signOut();
  }
}

class FireBaseServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Add a movie or show to the user's watchlist.
  Future<void> addWatching(String id, String status, String mediaType) async {
    List watchlist = await _firestore
        .collection("Data")
        .doc(_auth.currentUser!.uid)
        .get()
        .then((value) => value.data()!["WatchList"]);
    try {
      if (watchlist.any((element) => element["Id"] == id)) {
        await _firestore.collection("Data").doc(_auth.currentUser!.uid).update({
          "WatchList": FieldValue.arrayRemove([
            {
              "Id": id,
              "status": watchlist
                  .firstWhere((element) => element["Id"] == id)["status"],
              "mediaType": watchlist
                  .firstWhere((element) => element["Id"] == id)["mediaType"],
            }
          ])
        });
      }
      await _firestore.collection("Data").doc(_auth.currentUser!.uid).update({
        "WatchList": FieldValue.arrayUnion([
          {
            "Id": id,
            "status": status,
            "mediaType": mediaType,
          }
        ])
      });
    } catch (e) {
      // Handle error
    }
  }

  /// Fetch the entire watchlist for the current user.
  Future<List> getWatchList() async {
    List watchlist = await _firestore
        .collection("Data")
        .doc(_auth.currentUser!.uid)
        .get()
        .then((value) => value.data()!["WatchList"]);
    return watchlist;
  }
}