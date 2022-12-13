import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:todo_list/constants/constant.dart';
import 'package:todo_list/constants/error_handling.dart';
import 'package:todo_list/controller/task_controller.dart';
import 'package:todo_list/model/wallpaper.dart';
import 'package:todo_list/screens/upload_wall_screen.dart';

class WallpaperServices {
  void updateWallpaper({
    required String wallpaperName,
    required String wallpaperCategory,
    required String wallpaperURl,
    required String userName,
    required BuildContext context,
  }) async {
    http.Response response = await http.post(
      Uri.parse(
        "$url/post-wallpaper",
      ),
      body: jsonEncode(
        {
          'wallpaperName': wallpaperName,
          'wallpaperCategory': wallpaperCategory,
          'wallpaperUrl': wallpaperURl,
          'name': userName,
        },
      ),
      headers: {"Content-type": "application/json; charset=UTF-8"},
    );

    httpErrorHandle(
        response: response,
        context: context,
        onSuccess: () {
          Get.snackbar("Congratulation!!", "Wallpaper added successfully");
          Get.offAndToNamed(UploadWallpaperScreen.routeName);
        });
  }

  getWallpaper() async {
    TaskController taskController = Get.find();

    http.Response response = await http.get(
        Uri.parse(
          "$url/get-wallpaper",
        ),
        headers: {"Content-type": "application/json;charset=UTF-8"});

    for (int i = 0; i < jsonDecode(response.body).length; i++) {
      taskController.addWallList(
          wallpaper:
              Wallpaper.fromJson(jsonEncode(jsonDecode(response.body)[i])));
    }
    debugPrint("wallpaper => ${response.body}");
  }
}
