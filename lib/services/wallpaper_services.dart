import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class WallpaperServices {
  void getWallpaper() async {
    http.Response response = await http
        .get(Uri.parse("https://www.reddit.com/r/MobileWallpaper.json"));
    debugPrint("response = ${jsonDecode(response.body).runtimeType}");
  }
}
