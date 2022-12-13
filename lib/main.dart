import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/constants/constant.dart';
import 'package:todo_list/provider/user_provider.dart';
import 'package:todo_list/services/login_services.dart';
import 'package:todo_list/util/routes.dart';

void main() {
  runApp(ChangeNotifierProvider(
      create: (_) => UserProvider(), child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, provider, __) {
        return GetMaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
              useMaterial3: true,
              primarySwatch: Colors.blue,
              scaffoldBackgroundColor: scaffoldBackgroundColor),
          onInit: () => LoginServices().getUserData(context: context),
          initialRoute: "/",
          getPages: generateRoute(context: context),
        );
      },
    );
  }
}
