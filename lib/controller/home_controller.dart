import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  RxInt selectedIndexButtons = 1.obs;
  void changeColor(int index) {
    selectedIndexButtons.value = index;
    update();
  }

  Color getColorButtons(int index) {
    return selectedIndexButtons.value == index
        ? const Color(0xFFB74D3F)
        : Colors.black;
  }

  void changeIndex(int index) {
    selectedIndexButtons.value = index;
    update();
  }
}
