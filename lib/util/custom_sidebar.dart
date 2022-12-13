import 'package:flutter/material.dart';
import 'package:sidebarx/sidebarx.dart';

// ignore: must_be_immutable
class CustomSideBar extends StatelessWidget {
  CustomSideBar({
    Key? key,
    required this.sidebarXController,
    required this.sidebarItems,
  }) : super(key: key);

  final SidebarXController sidebarXController;
  List<SidebarXItem> sidebarItems = [];

  @override
  Widget build(BuildContext context) {
    return SidebarX(
      controller: sidebarXController,
      theme: SidebarXTheme(
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 1, 30, 53),
          borderRadius: BorderRadius.circular(20),
        ),
        hoverColor: const Color.fromARGB(255, 13, 41, 63),
        textStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
        selectedTextStyle: const TextStyle(color: Colors.white),
        itemTextPadding: const EdgeInsets.only(left: 30),
        selectedItemTextPadding: const EdgeInsets.only(left: 30),
        itemDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: const Color.fromARGB(255, 1, 30, 53)),
        ),
        selectedItemDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: const Color.fromARGB(255, 13, 41, 63).withOpacity(0.37),
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
      items: sidebarItems,

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
    );
  }
}
