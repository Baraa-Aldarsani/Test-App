// ignore_for_file: non_constant_identifier_names, avoid_print

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:test_baraa/api_services/api_services.dart';
import 'package:test_baraa/model/categories_model.dart';
import 'package:test_baraa/model/sub_categories_model.dart';

class DropdownController extends GetxController {
  var checkedValues = false.obs;
  var checkedSubValues = List<bool>.filled(0, false).obs;
  var categoreis = <CategoriesModel>[].obs;
  var subCategoreis = <SubCategoriesModel>[].obs;
  List<SubCategoriesModel> selectedSubIds = [];
  int id = -1;
  var selectedIndex = (-1).obs;
  @override
  void onInit() {
    super.onInit();
    fetchCategories();
    subCategoreis.listen((_) {
      updateSubCheckedValues();
    });
  }

  final TextEditingController name = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController city = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final TextEditingController bank_name = TextEditingController();
  final TextEditingController iban = TextEditingController();
  final TextEditingController code = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    name.dispose();
    email.dispose();
    password.dispose();
    city.dispose();
    phone.dispose();
    bank_name.dispose();
    iban.dispose();
    code.dispose();
  }

  void toggleCheckbox(int index) {
    if (selectedIndex.value == index) {
      selectedIndex.value = -1;
      update();
    } else {
      selectedIndex.value = index;
      id = index;
      update();
    }
  }

  void toggleSubCheckbox(int index, bool? value) {
    if (value != null) {
      checkedSubValues[index] = value;
    }
  }

  void updateSubCheckedValues() {
    checkedSubValues.value = List<bool>.filled(subCategoreis.length, false);
  }

  void sendSubSelectedCategoriesToDatabase() {
    selectedSubIds.clear();
    for (int i = 0; i < subCategoreis.length; i++) {
      if (checkedSubValues[i]) {
        selectedSubIds.add(subCategoreis[i]);
      }
    }
    update();
  }

  void removeNode(int index) {
    selectedSubIds.removeAt(index);
    update();
  }

  Future<void> fetchCategories() async {
    try {
      final List<CategoriesModel> fetchedCars =
          await ApiCategories.getAllCategories();
      categoreis.assignAll(fetchedCars);
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> fetchSubCategories(int id) async {
    try {
      print("id = $id");
      final List<SubCategoriesModel> fetchedCars =
          await ApiSubCategory.getSubCategories(id);
      subCategoreis.assignAll(fetchedCars);
      print("Sub Categories : ${subCategoreis.length}");
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> postRegisteration(
    double latitude,
    double longitude,
    File residency_photo,
    File photo,
    List<SubCategoriesModel> sub_categories,
  ) async {
    try {
      EasyLoading.show(
          status: 'loading...', maskType: EasyLoadingMaskType.black);
      await ApiRegisteration.signInWithEmailAndPassword(
          name.text,
          email.text,
          password.text,
          city.text,
          phone.text,
          latitude,
          longitude,
          residency_photo,
          photo,
          bank_name.text,
          iban.text,
          sub_categories,
          code.text);
      name.clear();
      email.clear();
      password.clear();
      city.clear();
      phone.clear();
      bank_name.clear();
      iban.clear();
      subCategoreis.clear();
      code.clear();
    } catch (e) {
      print(e.toString());
    }
  }
}
