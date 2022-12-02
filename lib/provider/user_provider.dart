import 'package:flutter/cupertino.dart';

import '../model/user.dart';

class UserProvider extends ChangeNotifier {
  User _users = User(
    name: "",
    email: "",
    password: "",
    token: "",
  );

  User get getUser => _users;

  void setUser(String user) {
    _users = User.fromJson(user);
    notifyListeners();
  }
}
