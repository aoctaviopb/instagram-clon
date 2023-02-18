import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagram_clone/resources/storage_methods.dart';
import 'package:instagram_clone/models/user.dart' as model;

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<model.User?> getUserDetails() async {
    User currentUser = _auth.currentUser!;

    DocumentSnapshot snap =
        await _firestore.collection('users').doc(currentUser.uid).get();

    print('documentSnapshot: $snap');
    if (snap == null) return null;

    return model.User.fromSnap(snap);
  }

  Future<String> signUpUser({
    required String email,
    required String password,
    required String username,
    required String bio,
    required Uint8List? file,
  }) async {
    String res = 'Some error ocurred';
    String photoUrl = '';
    try {
      if (email.isNotEmpty ||
          password.isNotEmpty ||
          username.isNotEmpty ||
          bio.isNotEmpty ||
          file != null) {
        //register user
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        if (file != null) {
          photoUrl = await StorageMethods()
              .uploadImageToStorage('profilePics', file, false);
        } else {
          photoUrl = 'https://i.stack.imgur.com/l60Hf.png';
        }
        //add user to our database

        model.User _user = model.User(
            email: email,
            uid: cred.user!.uid,
            photoUrl: photoUrl,
            username: username,
            bio: bio,
            followers: [],
            following: []);

        await _firestore.collection('users').doc(cred.user!.uid).set(
              _user.toJson(),
            );

        res = 'success';
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  //Login User

  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    String res = 'Some error occurred';

    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        res = 'success';
      } else {
        res = 'Please enter all the fields';
      }
    } /* on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        
      }

    }  */
    catch (e) {
      res = e.toString();
    }
    return res;
  }
}





/*


class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<model.User> getUserDetails() async {
    User currentUser = _auth.currentUser!;

    DocumentSnapshot snap =
        await _firestore.collection('users').doc(currentUser.uid).get();

    return model.User.fromSnap(snap);
  }

  Future<String> signUpUser({
    required String email,
    required String password,
    required String username,
    required String bio,
    required Uint8List? file,
  }) async {
    String res = 'Some error ocurred';
    String photoUrl = '';
    try {
      if (email.isNotEmpty ||
          password.isNotEmpty ||
          username.isNotEmpty ||
          bio.isNotEmpty ||
          file != null) {
        //register user
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        if (file != null) {
          photoUrl = await StorageMethods()
              .uploadImageToStorage('profilePics', file, false);
        } else {
          photoUrl = 'https://i.stack.imgur.com/l60Hf.png';
        }
        //add user to our database

        model.User _user = model.User(
            email: email,
            uid: cred.user!.uid,
            photoUrl: photoUrl,
            username: username,
            bio: bio,
            followers: [],
            following: []);

        await _firestore.collection('users').doc(cred.user!.uid).set(
              _user.toJson(),
            );

        res = 'success';
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  //Login User

  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    String res = 'Some error occurred';

    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        res = 'success';
      } else {
        res = 'Please enter all the fields';
      }
    } /* on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        
      }

    }  */
    catch (e) {
      res = e.toString();
    }
    return res;
  }
}

*/
