// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:todo_list/util/custom_text_field.dart';

import '../services/login_services.dart';

class SignInSignUpWidget extends StatelessWidget {
  const SignInSignUpWidget({
    Key? key,
    required this.userNameController,
    required this.passwordController,
    required this.nameController,
    required this.loginServices,
    required this.buttonText,
    required this.onTap,
  }) : super(key: key);

  final TextEditingController userNameController;
  final TextEditingController passwordController;
  final TextEditingController nameController;
  final LoginServices loginServices;
  final String buttonText;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Form(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              FormField(
                builder: (val) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CustomTextField(
                          textEditingController: userNameController,
                          hintText: "User Name"),
                      CustomTextField(
                          textEditingController: passwordController,
                          hintText: "Password"),
                      buttonText == "Sign Up"
                          ? CustomTextField(
                              textEditingController: nameController,
                              hintText: "Name")
                          : Container(),
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
                    child: Text(
                      buttonText,
                    ),
                  ),
                  // ElevatedButton(
                  //   onPressed: () {
                  // Get.defaultDialog(
                  //     title: "What do people call you?",
                  //     content: TextField(
                  //       controller: nameController,
                  //       decoration: InputDecoration(
                  //         hintText: "Name",
                  //       ),
                  //     ),
                  //     actions: [
                  //       ElevatedButton(
                  //         onPressed: () {
                  //           loginServices.signUpUser(
                  //             name: nameController.text,
                  //             email: userNameController.text,
                  //             password: passwordController.text,
                  //             context: context,
                  //           );
                  //         },
                  //         child: const Text("Sign Up"),
                  //       ),
                  //       ElevatedButton(
                  //         onPressed: () => Navigator.pop(context),
                  //         child: const Text("Close"),
                  //       ),
                  //     ]);
                  //   },
                  //   child: const Text(
                  //     "Sign Up",
                  //   ),
                  // ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
