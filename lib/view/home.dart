// ignore_for_file: unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_baraa/controller/home_controller.dart';
import 'package:test_baraa/view/new_registration.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final controller = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Obx(
          () => SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        TextButton(
                          onPressed: () {
                            controller.changeColor(0);
                            controller.changeIndex(0);
                          },
                          child: Text(
                            "تسجيل دخول",
                            style:
                                TextStyle(color: controller.getColorButtons(0)),
                          ),
                        ),
                        if (controller.selectedIndexButtons.value == 0)
                          Container(
                            height: 1.2,
                            color: controller.getColorButtons(0),
                            width: 80,
                          )
                      ],
                    ),
                    Column(
                      children: [
                        TextButton(
                          onPressed: () {
                            controller.changeColor(1);
                            controller.changeIndex(1);
                          },
                          child: Text("تسجيل جديد",
                              style: TextStyle(
                                  color: controller.getColorButtons(1))),
                        ),
                        if (controller.selectedIndexButtons.value == 1)
                          Container(
                            height: 1.2,
                            color: controller.getColorButtons(1),
                            width: 80,
                          )
                      ],
                    ),
                    const SizedBox(
                      width: 50,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                if (controller.selectedIndexButtons == 1) NewRegistration()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
