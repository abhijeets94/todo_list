import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/constants/constant.dart';
import 'package:todo_list/controller/task_controller.dart';
import 'package:todo_list/provider/user_provider.dart';
import 'package:todo_list/services/wallpaper_services.dart';
import 'package:todo_list/util/custom_text_field.dart';
import 'package:url_launcher/url_launcher.dart';

import '../model/wallpaper.dart';

class UploadWallpaperScreen extends StatefulWidget {
  static const String routeName = "/upload-wallpaper";
  const UploadWallpaperScreen({Key? key}) : super(key: key);

  @override
  State<UploadWallpaperScreen> createState() => _UploadWallpaperScreenState();
}

class _UploadWallpaperScreenState extends State<UploadWallpaperScreen> {
  TextEditingController wallpaperUrlController = TextEditingController();
  TextEditingController wallpaperNameController = TextEditingController();
  TextEditingController wallpaperCategoryController = TextEditingController();

  WallpaperServices wallpaperServices = WallpaperServices();

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
    String userName = Provider.of<UserProvider>(context).getUser.name;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.defaultDialog(
            contentPadding: const EdgeInsets.all(0),
            title: "Add wallpaper link",
            titleStyle: const TextStyle(
              color: Colors.white,
              fontFamily: "NerkoOne-Regular",
              fontSize: 20,
              fontWeight: FontWeight.w100,
            ),
            backgroundColor: scaffoldBackgroundColor,
            content: Container(
              width: MediaQuery.of(context).size.height / 2.5,
              height: MediaQuery.of(context).size.height / 2.5,
              color: scaffoldBackgroundColor,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    CustomTextField(
                        textEditingController: wallpaperNameController,
                        hintText: "Enter Wallpaper Name"),
                    CustomTextField(
                        textEditingController: wallpaperCategoryController,
                        hintText: "Enter Wallpaper Category"),
                    CustomTextField(
                        textEditingController: wallpaperUrlController,
                        hintText: "Enter Wallpaper URL"),
                    ElevatedButton(
                      onPressed: () {
                        wallpaperServices.updateWallpaper(
                            wallpaperName: wallpaperNameController.text,
                            wallpaperCategory: wallpaperCategoryController.text,
                            wallpaperURl: wallpaperUrlController.text,
                            userName: userName,
                            context: context);
                      },
                      style: ElevatedButton.styleFrom(
                        primary: scaffoldBackgroundColor.withBlue(78),
                      ),
                      child: const Text(
                        "Submit",
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: "NerkoOne-Regular",
                          fontSize: 20,
                          fontWeight: FontWeight.w100,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ).then((value) => setState(() {}));
        },
        child: const Icon(Icons.add_outlined),
      ),
      body: SafeArea(
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
              debugPrint("name 1${taskController.wallList[0].name}");
              debugPrint(
                  "name 2 ${Provider.of<UserProvider>(context).getUser.name}");
              return Expanded(
                child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisSpacing: 2.5,
                      crossAxisCount: 2,
                    ),
                    itemCount: taskController.wallList.length,
                    itemBuilder: (context, index) {
                      return taskController.wallList[0].name ==
                              Provider.of<UserProvider>(context).getUser.name
                          ? InkWell(
                              onTap: () => _launchURL(Uri.parse(
                                  taskController.wallList[index].wallpaperUrl)),
                              onLongPress: () async {
                                try {
                                  // Saved with this method.
                                  var imageId =
                                      await ImageDownloader.downloadImage(
                                          taskController
                                              .wallList[index].wallpaperUrl);
                                  if (imageId == null) {
                                    return;
                                  }

                                  // Below is a method of obtaining saved image information.
                                  var fileName =
                                      await ImageDownloader.findName(imageId);
                                  var path =
                                      await ImageDownloader.findPath(imageId);
                                  var size = await ImageDownloader.findByteSize(
                                      imageId);
                                  var mimeType =
                                      await ImageDownloader.findMimeType(
                                          imageId);
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
                            )
                          : Container();
                    }),
              );
            }),
          ],
        ),
      ),
    );
  }
}
