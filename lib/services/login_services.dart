import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_list/constants/error_handling.dart';
import 'package:todo_list/model/user.dart';
import 'package:todo_list/provider/user_provider.dart';
import 'package:todo_list/screens/homescreen.dart';

import '../constants/constant.dart';

class LoginServices {
  void signUpUser({
    required String name,
    required String email,
    required String password,
    String? userType,
    required BuildContext context,
  }) async {
    debugPrint("name, email, password = $name, $email, $password");
    User user = User(
      name: name,
      email: email,
      password: password,
      token: "",
      userType: "",
    );

    try {
      http.Response response = await http.post(
        Uri.parse("$url/api/signUp"),
        body: user.toJson(),
        headers: {
          'Content-type': 'application/json; charset=UTF-8',
        },
      );

      httpErrorHandle(
          response: response,
          context: context,
          onSuccess: () {
            Get.snackbar(
              "Account created Successfully!!",
              "",
            );
            Navigator.pop(context);
          });
    } catch (e) {
      Get.snackbar(
        "Error : $e",
        "",
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void signInUser({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      debugPrint("email: $email, password: $password");
      http.Response response = await http.post(Uri.parse("$url/api/signIn"),
          body: jsonEncode(
            {
              'email': email,
              'password': password,
            },
          ),
          headers: {"Content-type": "application/json; charset=UTF-8"});

      httpErrorHandle(
        response: response,
        context: context,
        onSuccess: () async {
          Provider.of<UserProvider>(context, listen: false)
              .setUser(response.body);
          final prefs = await SharedPreferences.getInstance();

          await prefs.setString(
              'auth-token', json.decode(response.body)['token']);

          Get.toNamed(HomeScreen.routeName);
        },
      );
    } catch (e) {
      Get.snackbar(
        "TOken invalid",
        "",
      );
    }
  }

  void getUserData({required BuildContext context}) async {
    try {
      SharedPreferences saved = await SharedPreferences.getInstance();
      String? token = saved.getString("auth-token");
      if (token == null) {
        saved.setString('auth-token', '');
      }

      http.Response tokenResponse = await http.post(
        Uri.parse("$url/isTokenValid"),
        headers: {
          "Content-type": "application/json; charset=UTF-8",
          "auth-token": token!,
        },
      );

      var response = jsonDecode(tokenResponse.body);

      if (response == true) {
        http.Response userResponse = await http.post(
          Uri.parse("$url/"),
          headers: {
            'Content-type': 'application/json;charset=UTF-8',
            'auth-token': token,
          },
        );
        // ignore: use_build_context_synchronously
        Provider.of<UserProvider>(context, listen: false)
            .setUser(userResponse.body);
      }
    } catch (e) {
      Get.snackbar("Error", "$e");
    }
  }
}
