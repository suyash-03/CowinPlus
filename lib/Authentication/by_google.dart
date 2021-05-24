import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignInWithGoogle extends ChangeNotifier {
  final googleSignIn = GoogleSignIn();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  bool _isSigningIn;

  SignInWithGoogle() {
    _isSigningIn = false;
  }

  //Getter and Setter
  bool get isSigningIn => _isSigningIn;

  set isSigningIn(bool isSigningIn) {
    _isSigningIn = isSigningIn;
    notifyListeners();
  }


  // ignore: non_constant_identifier_names
  Future SignInGoogle(BuildContext context) async {
    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    if (googleSignInAccount == null) {
      print('Account Not Found');
      isSigningIn = false;
    }
    else {
      final GoogleSignInAuthentication googleAuth = await googleSignInAccount
          .authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final UserCredential authResult = await firebaseAuth.signInWithCredential(
          credential);
      final User user = authResult.user;
      isSigningIn = true;

      var userData = {
        'name': googleSignInAccount.displayName,
        'provider': 'google',
        'photoUrl': googleSignInAccount.photoUrl,
        'email': googleSignInAccount.email,
      };

      users.doc(user.uid).get().then((doc) =>
      {
        if(doc.exists){
          doc.reference.update(userData)
        } else
          {
            users.doc(user.uid).set(userData)
          }
      });
    }
  }

  // ignore: non_constant_identifier_names
  Future SignOutGoogle(BuildContext context) async {
    await googleSignIn.disconnect();
    firebaseAuth.signOut();
    isSigningIn = false;
  }

}