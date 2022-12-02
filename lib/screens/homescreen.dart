import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sidebarx/sidebarx.dart';
import 'package:todo_list/provider/user_provider.dart';
import 'package:todo_list/screens/login_screen.dart';
import 'package:todo_list/services/wallpaper_services.dart';

import '../model/user.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "/home";
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  WallpaperServices wallpaperServices = WallpaperServices();
  SidebarXController sidebarXController = SidebarXController(selectedIndex: 0);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WallpaperServices().getWallpaper();
  }

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<UserProvider>(context).getUser;
    var wallpaperResponse = wallpaperServices.getWallpaper();
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 38, 48, 65),
      appBar: AppBar(
        title: const Text(
          "Walter",
          style: TextStyle(
            color: Colors.white,
            fontSize: 40,
            fontWeight: FontWeight.w600,
            fontFamily: "NerkoOne-Regular",
          ),
        ),
        backgroundColor: Color.fromARGB(255, 13, 41, 63),
      ),
      body: SidebarX(
        controller: sidebarXController,
        theme: SidebarXTheme(
          margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 1, 30, 53),
            borderRadius: BorderRadius.circular(20),
          ),
          hoverColor: Color.fromARGB(255, 13, 41, 63),
          textStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
          selectedTextStyle: const TextStyle(color: Colors.white),
          itemTextPadding: const EdgeInsets.only(left: 30),
          selectedItemTextPadding: const EdgeInsets.only(left: 30),
          itemDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Color.fromARGB(255, 1, 30, 53)),
          ),
          selectedItemDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: Color.fromARGB(255, 13, 41, 63).withOpacity(0.37),
            ),
            gradient: const LinearGradient(
              colors: [
                Color.fromARGB(255, 38, 86, 126),
                Color.fromARGB(255, 1, 23, 41)
              ],
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.28),
                blurRadius: 30,
              )
            ],
          ),
          iconTheme: IconThemeData(
            color: Colors.white.withOpacity(0.7),
            size: 20,
          ),
          selectedIconTheme: const IconThemeData(
            color: Colors.white,
            size: 20,
          ),
        ),
        extendedTheme: const SidebarXTheme(
          width: 200,
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 1, 30, 53),
          ),
        ),
        items: [
          SidebarXItem(
            icon: Icons.home,
            label: 'Home',
            onTap: () {
              Get.offAndToNamed(HomeScreen.routeName);
            },
          ),
          SidebarXItem(
              icon: Icons.logout,
              label: 'Logout',
              onTap: () async {
                Provider.of<UserProvider>(context, listen: false).removeUser();
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.setString("auth-value", "");
                Get.offNamedUntil(LoginScreen.routeName, (route) => false);
              }),
        ],

        //   child: GlassmorphicContainer(
        //     width: 200,
        //     height: 200,
        //     borderRadius: 12,
        //     border: 12,
        //     linearGradient: const LinearGradient(
        //       colors: [
        //         Colors.white54,
        //         Color.fromARGB(255, 187, 222, 251),
        //       ],
        //     ),
        //     blur: 2,
        //     borderGradient: const LinearGradient(
        //       colors: [
        //         Colors.white54,
        //         Color.fromARGB(255, 187, 222, 251),
        //       ],
        //     ),
        //     child: Container(
        //       decoration: const BoxDecoration(
        //         image: DecorationImage(
        //           fit: BoxFit.cover,
        //           image: NetworkImage(
        //             "https://images.pexels.com/photos/1187079/pexels-photo-1187079.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
        //           ),
        //         ),
        //       ),
        //     ),
        //   ),
      ),
    );
  }
}
