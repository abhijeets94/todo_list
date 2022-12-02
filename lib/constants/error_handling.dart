import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

void httpErrorHandle({
  required http.Response response,
  required BuildContext context,
  required VoidCallback onSuccess,
}) {
  switch (response.statusCode) {
    case 200:
      onSuccess();
      break;
    case 400:
      Get.snackbar(
        jsonDecode(response.body)['msg'],
        "",
        snackPosition: SnackPosition.BOTTOM,
      );
      break;
    case 500:
      Get.snackbar(jsonDecode(response.body)['error'], "");
      break;
    default:
      Get.snackbar(response.body, "");
  }
}
