import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sidebarx/sidebarx.dart';
import 'package:todo_list/provider/user_provider.dart';
import 'package:todo_list/screens/login_screen.dart';
import 'package:todo_list/services/wallpaper_services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../controller/task_controller.dart';
import '../model/wallpaper.dart';
import '../util/custom_sidebar.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "/home";
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  WallpaperServices wallpaperServices = WallpaperServices();
  SidebarXController sidebarXController = SidebarXController(
    selectedIndex: 0,
  );

  TaskController taskController = Get.put(TaskController());
  List<Wallpaper> wallpapers = [];

  @override
  void initState() {
    super.initState();
    taskController.wallList.value = [];
    fetchWallpaper();
  }

  void fetchWallpaper() async {
    await wallpaperServices.getWallpaper();
  }

  void _launchURL(Uri url) async {
    if (!await launchUrl(url, mode: LaunchMode.platformDefault)) {
      throw 'Could not launch $url ';
    }
  }

  @override
  Widget build(BuildContext context) {
    // var user = Provider.of<UserProvider>(context).getUser;
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
          Expanded(
            child: AnimatedBuilder(
              animation: sidebarXController,
              builder: (context, child) {
                switch (sidebarXController.selectedIndex) {
                  case 0:
                    return SafeArea(
                      child: Column(
                        children: [
                          const Text(
                            "Walter",
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: "NerkoOne-Regular",
                              fontSize: 80,
                              fontWeight: FontWeight.w100,
                            ),
                          ),
                          Obx(() {
                            return Expanded(
                              child: GridView.builder(
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisSpacing: 2.5,
                                    crossAxisCount: 2,
                                  ),
                                  itemCount: taskController.wallList.length,
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      onTap: () => _launchURL(Uri.parse(
                                          taskController
                                              .wallList[index].wallpaperUrl)),
                                      onLongPress: () async {
                                        try {
                                          // Saved with this method.
                                          var imageId = await ImageDownloader
                                              .downloadImage(taskController
                                                  .wallList[index]
                                                  .wallpaperUrl);
                                          if (imageId == null) {
                                            return;
                                          }

                                          // Below is a method of obtaining saved image information.
                                          var fileName =
                                              await ImageDownloader.findName(
                                                  imageId);
                                          var path =
                                              await ImageDownloader.findPath(
                                                  imageId);
                                          var size = await ImageDownloader
                                              .findByteSize(imageId);
                                          var mimeType = await ImageDownloader
                                              .findMimeType(imageId);
                                        } on PlatformException catch (error) {
                                          print(error);
                                        }
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: NetworkImage(
                                              taskController
                                                  .wallList[index].wallpaperUrl,
                                            ),
                                          ),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8.0),
                                          child: Text(
                                            taskController
                                                .wallList[index].wallpaperName,
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 20,
                                                fontFamily: "NerkoOne-Regular"),
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                            );
                          }),
                        ],
                      ),
                    );
                  default:
                    return Container();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
