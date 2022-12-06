import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/screens/homescreen.dart';
import 'package:todo_list/screens/login_screen.dart';
import 'package:todo_list/screens/upload_wall_screen.dart';

import '../provider/user_provider.dart';

generateRoute({required BuildContext context}) {
  return [
    GetPage(
      name: "/",
      page: () => Provider.of<UserProvider>(context).getUser.token.isNotEmpty
          ? HomeScreen()
          : const LoginScreen(),
    ),
    GetPage(
      name: LoginScreen.routeName,
      page: () => const LoginScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: HomeScreen.routeName,
      page: () => HomeScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: UploadWallpaperScreen.routeName,
      page: () => const UploadWallpaperScreen(),
      transition: Transition.cupertino,
    )
  ];
}
