import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class UploadWallpaperScreen extends StatefulWidget {
  const UploadWallpaperScreen({Key? key}) : super(key: key);

  @override
  State<UploadWallpaperScreen> createState() => _UploadWallpaperScreenState();
}

class _UploadWallpaperScreenState extends State<UploadWallpaperScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Admin"),
      ),
    );
  }
}
