// ignore_for_file: prefer_const_constructors, must_be_immutable

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_baraa/controller/controller.dart';
import 'package:test_baraa/core/core.dart';
import 'package:test_baraa/view/view.dart';

class NewRegistration extends StatelessWidget {
  NewRegistration({super.key});
  final _cont = Get.put(NewRegistrationController());
  final _controller = Get.put(DropdownController());
  final _latlng = Get.put(MapBoxController());
  int id = -1;
  final GlobalKey<FormState> _formstate = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: DropdownController(),
      builder: (controller) => Form(
        key: _formstate,
        child: Column(
          children: [
            Obx(
              () => Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: ClipOval(
                      child: SizedBox(
                        width: 99,
                        height: 99,
                        child: _cont.image == null
                            ? Container(
                                color: const Color(0xFFE7E7E7),
                              )
                            : Image.file(
                                File(_cont.image!.path),
                                fit: BoxFit.cover,
                              ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 5,
                    right: 5,
                    child: Container(
                      width: 30,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(8),
                        ),
                      ),
                      child: InkWell(
                        child: Image.asset("assets/images/camera 1.png",
                            color: Colors.grey),
                        onTap: () {
                          _cont.selectImage();
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            CustomTextFromField(
              controller: _controller.name,
              hintText: "الإسم",
              icon: 'assets/images/name 1.png',
              keyboardType: TextInputType.name,
              hintColor: Colors.grey,
            ),
            const SizedBox(height: 12),
            CustomTextFromField(
              controller: _controller.phone,
              hintText: "رقم الجوال",
              icon: 'assets/images/Phone_smartphone.png',
              keyboardType: TextInputType.phone,
              hintColor: Colors.grey,
            ),
            const SizedBox(height: 12),
            CustomTextFromField(
              controller: _controller.email,
              hintText: "الإيميل",
              icon: 'assets/images/email.png',
              keyboardType: TextInputType.emailAddress,
              hintColor: Colors.grey,
            ),
            const SizedBox(height: 12),
            CustomTextFromField(
              controller: _controller.password,
              hintText: "كلمة المرور",
              icon: 'assets/images/Vector (3).png',
              obscureText: true,
              hintColor: Colors.grey,
            ),
            const SizedBox(height: 12),
            CustomTextFromField(
              controller: _controller.city,
              hintText: "المدينة",
              icon: 'assets/images/Group (1).png',
              keyboardType: TextInputType.streetAddress,
              hintColor: Colors.grey,
            ),
            const SizedBox(height: 12),
            Container(
              height: 55,
              width: double.infinity,
              padding: const EdgeInsets.all(8),
              margin: const EdgeInsets.only(left: 20),
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.grey),
                  borderRadius: const BorderRadius.all(Radius.circular(10))),
              child: PopupMenuButton<int>(
                itemBuilder: (BuildContext context) {
                  return List.generate(
                    _controller.categoreis.length,
                    (index) {
                      return PopupMenuItem(
                          value: index,
                          child: FutureBuilder(
                            future: _controller.fetchCategories(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const SizedBox();
                              } else if (snapshot.hasError) {
                                return const Text("No Data");
                              } else {
                                return Obx(
                                  () => CheckboxListTile(
                                    activeColor: primaryColor,
                                    title: Text(
                                        _controller.categoreis[index].name),
                                    value: _controller.selectedIndex.value ==
                                        index,
                                    onChanged: (bool? value) {
                                      _controller.toggleCheckbox(index);
                                      id = _controller.categoreis[index].id;
                                      _controller.fetchSubCategories(id);
                                    },
                                  ),
                                );
                              }
                            },
                          ));
                    },
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Image.asset("assets/images/Vector.png", scale: 4),
                        const SizedBox(width: 10),
                        const Text(
                          "الخدمة العامة",
                          style: TextStyle(fontSize: 13, color: Colors.grey),
                        ),
                      ],
                    ),
                    const Icon(Icons.arrow_drop_down, color: Colors.grey),
                  ],
                ),
                onSelected: (value) {
                  _controller.toggleCheckbox(value);
                },
              ),
            ),
            const SizedBox(height: 12),
            Container(
              height: 55,
              width: double.infinity,
              padding: const EdgeInsets.all(8),
              margin: const EdgeInsets.only(left: 20),
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.grey),
                  borderRadius: const BorderRadius.all(Radius.circular(10))),
              child: PopupMenuButton<int>(
                itemBuilder: (BuildContext context) {
                  List<PopupMenuEntry<int>> menuItems = List.generate(
                      _controller.checkedSubValues.length, (index) {
                    return PopupMenuItem(
                        value: index,
                        child: FutureBuilder(
                            future: _controller.fetchSubCategories(id),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const SizedBox();
                              } else if (snapshot.hasError) {
                                return const Text("No Data");
                              } else {
                                return Obx(() => CheckboxListTile(
                                      activeColor: primaryColor,
                                      title: Text(_controller
                                          .subCategoreis[index].name),
                                      value:
                                          _controller.checkedSubValues[index],
                                      onChanged: (bool? value) {
                                        _controller.toggleSubCheckbox(
                                            index, value);
                                      },
                                    ));
                              }
                            }));
                  });
                  menuItems.add(
                    PopupMenuItem(
                      value: _controller.checkedSubValues
                          .length, // Unique value for the button
                      child: Align(
                        alignment: Alignment.center,
                        child: MaterialButton(
                          height: 27,
                          minWidth: 96,
                          color: primaryColor,
                          onPressed: () {
                            _controller.sendSubSelectedCategoriesToDatabase();
                          },
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          child: const Text("إضافة",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                              )),
                        ),
                      ),
                    ),
                  );

                  return menuItems;
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Image.asset("assets/images/Group.png", scale: 4),
                        const SizedBox(width: 10),
                        const Text(
                          "الخدمة الفرعية",
                          style: TextStyle(fontSize: 13, color: Colors.grey),
                        ),
                      ],
                    ),
                    const Icon(
                      Icons.arrow_drop_down,
                      color: Colors.grey,
                    ),
                  ],
                ),
                onSelected: (value) {
                  _controller.toggleSubCheckbox(
                      value, !_controller.checkedSubValues[value]);
                },
              ),
            ),
            if (controller.id != -1)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          "${controller.categoreis[controller.id].name}: ",
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 280,
                        height: 40,
                        child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemCount: controller.selectedSubIds.length,
                            itemBuilder: (context, index) {
                              return Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10)),
                                    color: primaryColor),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        controller.removeNode(index);
                                      },
                                      child: Icon(
                                        Icons.close,
                                        color: Colors.white,
                                        size: 20,
                                      ),
                                    ),
                                    Text(
                                      controller.selectedSubIds[index].name,
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                            separatorBuilder:
                                (BuildContext context, int index) =>
                                    const SizedBox(
                                      width: 4,
                                    )),
                      )
                    ],
                  ),
                ],
              ),
            const SizedBox(height: 12),
            CustomTextFromField(
              controller: _controller.bank_name,
              hintText: "اسم البنك",
              icon: 'assets/images/bank 1 (1).png',
              keyboardType: TextInputType.name,
              hintColor: Colors.grey,
            ),
            const SizedBox(height: 12),
            CustomTextFromField(
              controller: _controller.iban,
              hintText: "رقم أيبان",
              icon: 'assets/images/Page-1.png',
              keyboardType: TextInputType.number,
              hintColor: Colors.grey,
            ),
            const SizedBox(height: 12),
            CustomTextFromField(
              hintText: "الموقع الجغرافي",
              icon: 'assets/images/Vector (2).png',
              keyboardType: TextInputType.emailAddress,
              hintColor: Colors.grey,
            ),
            const SizedBox(height: 12),
            Container(
              height: 130,
              margin: const EdgeInsets.only(left: 20, right: 5),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: MapBox(),
              ),
            ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Row(
                children: [
                  Image.asset("assets/images/Vector (4).png", scale: 4),
                  const SizedBox(width: 20),
                  const Text("صورة الإقامة",
                      style: TextStyle(
                        color: Colors.grey,
                        height: 1,
                        fontSize: 13,
                      ))
                ],
              ),
            ),
            Obx(
              () => InkWell(
                onTap: () {
                  _cont.selectImage(res: true);
                },
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.grey),
                      borderRadius: BorderRadius.circular(10)),
                  margin: const EdgeInsets.only(left: 20, right: 10, top: 12),
                  width: double.infinity,
                  height: 99,
                  child: _cont.imageRes == null
                      ? Image.asset("assets/images/Icons.png")
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(9),
                          child: Image.file(
                            File(_cont.imageRes!.path),
                            fit: BoxFit.cover,
                          ),
                        ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 10, top: 12),
              child: MaterialButton(
                height: 52,
                minWidth: double.infinity,
                color: primaryColor,
                onPressed: () {
                  if (_formstate.currentState!.validate()) {
                    _controller.postRegisteration(
                      _latlng.latlong.latitude,
                      _latlng.latlong.longitude,
                      _cont.imageRes!,
                      _cont.image!,
                      _controller.selectedSubIds,
                    );
                  }
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25)),
                child: const Text(
                  "تسجيل جديد",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
