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
import '../util/custom_sidebar.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "/home";
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  WallpaperServices wallpaperServices = WallpaperServices();
  SidebarXController sidebarXController =
      SidebarXController(selectedIndex: 0, extended: true);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // WallpaperServices().getWallpaper();
  }

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<UserProvider>(context).getUser;
    // var wallpaperResponse = wallpaperServices.getWallpaper();
    return Scaffold(
      body: Row(
        children: [
          CustomSideBar(
            sidebarXController: sidebarXController,
            sidebarItems: [
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
                    Provider.of<UserProvider>(context, listen: false)
                        .removeUser();
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    prefs.setString("auth-token", "");
                    Get.offNamedUntil(LoginScreen.routeName, (route) => false);
                  }),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              Text(
                "Walter",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                  fontWeight: FontWeight.w600,
                  fontFamily: "NerkoOne-Regular",
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
