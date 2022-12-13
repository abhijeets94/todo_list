import 'package:get/get.dart';

import '../model/wallpaper.dart';

class TaskController extends GetxController {
  var wallList = [].obs;
  RxInt i = 0.obs;
  void addWallList({required Wallpaper wallpaper}) {
    wallList.add(wallpaper);
    update();
  }

  // void onReady() {

  //   super.onReady();
  // }
}
