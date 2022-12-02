import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/provider/user_provider.dart';
import 'package:todo_list/screens/homescreen.dart';
import 'package:todo_list/screens/upload_wall_screen.dart';
import 'package:todo_list/services/login_services.dart';
import 'package:todo_list/util/custom_text_field.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = "/login-screen";
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  LoginServices loginServices = LoginServices();

  bool colorChanged = true;
  List<Color> colorList = [
    Colors.blue,
    Colors.purple,
  ];

  double height = 1080 * 0.5;

  int i = 0;
  bool signUp = false;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;

    return Provider.of<UserProvider>(context).getUser.token.isNotEmpty
        ? Provider.of<UserProvider>(context).getUser.userType == "user"
            ? HomeScreen()
            : const UploadWallpaperScreen()
        : Scaffold(
            body: Center(
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      width: double.maxFinite,
                      height: height,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(150),
                          topLeft: Radius.circular(150),
                        ),
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Colors.cyan,
                            Colors.blue,
                            Colors.lightBlueAccent,
                            Colors.deepPurpleAccent,
                          ],
                        ),
                      ),
                      child: Text(
                        "Wallpaper",
                        style: text.headline1,
                        textAlign: TextAlign.end,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(4),
                    child: Form(
                      child: Column(
                        children: [
                          FormField(
                            builder: (val) {
                              return Column(
                                children: [
                                  CustomTextField(
                                      textEditingController: userNameController,
                                      hintText: "User Name"),
                                  CustomTextField(
                                      textEditingController: passwordController,
                                      hintText: "Password"),
                                ],
                              );
                            },
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  LoginServices().signInUser(
                                    email: userNameController.text,
                                    password: passwordController.text,
                                    context: context,
                                  );
                                },
                                child: const Text(
                                  "Sign In",
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  Get.defaultDialog(
                                      title: "What do people call you?",
                                      content: TextField(
                                        controller: nameController,
                                        decoration: InputDecoration(
                                          hintText: "Name",
                                        ),
                                      ),
                                      actions: [
                                        ElevatedButton(
                                          onPressed: () {
                                            loginServices.signUpUser(
                                              name: nameController.text,
                                              email: userNameController.text,
                                              password: passwordController.text,
                                              context: context,
                                            );
                                          },
                                          child: const Text("Sign Up"),
                                        ),
                                        ElevatedButton(
                                          onPressed: () =>
                                              Navigator.pop(context),
                                          child: const Text("Close"),
                                        ),
                                      ]);
                                },
                                child: const Text(
                                  "Sign Up",
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
