import 'package:flutter/material.dart';
import 'package:instagram_clone/models/user.dart';
import 'package:instagram_clone/resources/auth_methods.dart';
//import 'package:flutter/widgets.dart';

class UserProvider with ChangeNotifier{
  
  User? _user;
  final AuthMethods _authMethods = AuthMethods();
  

  Future<void> refreshUser() async {
    User? user = await AuthMethods().getUserDetails();//await _authMethods.getUserDetails();
    _user = user!;
    notifyListeners();
  }

    User? get getUser => _user;
}