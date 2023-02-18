import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String? email;
  final String? uid;
  final String? photoUrl;
  final String? username;
  final String? bio;
  final List<dynamic>? followers;
  final List<dynamic>? following;

  const User(
      {required this.email,
      required this.uid,
      required this.photoUrl,
      required this.username,
      required this.bio,
      required this.followers,
      required this.following});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['username'] = username;
    data['uid'] = uid;
    data['bio'] = bio;
    data['photoUrl'] = photoUrl;
    data['followers'] = followers;
    data['following'] = following;
    return data;
  }

/*   Map<String, dynamic> toJson() => {
        'email': email,
        'uid': uid,
        'photoUrl': photoUrl,
        'username': username,
        'bio': bio,
        'followers': followers,
        'following': following,
      }; */

  static User fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return User(
        email: snapshot["email"],
        username: snapshot["username"],
        uid: snapshot["uid"],
        bio: snapshot["bio"],
        photoUrl: snapshot["photoUrl"],
        followers: snapshot["followers"],
        following: snapshot["following"]);
  }

/*   static User fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return User(
      email: snapshot['email'],
      uid: snapshot['uid'],
      photoUrl: snapshot['photoUrl'],
      username: snapshot['username'],
      bio: snapshot['bio'],
      followers: snapshot['followers'],
      following: snapshot['following'],
    );
  } */
}
