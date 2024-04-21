// ignore_for_file: non_constant_identifier_names, deprecated_member_use, avoid_print

import 'dart:io';
import 'package:async/async.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:http/http.dart' as http;
import 'package:test_baraa/core/constant.dart';
import 'package:test_baraa/model/sub_categories_model.dart';

class ApiRegisteration {
  static Future<void> signInWithEmailAndPassword(
    String name,
    String email,
    String password,
    String city,
    String phone,
    double latitude,
    double longitude,
    File residency_photo,
    File photo,
    String bank_name,
    String iban,
    List<SubCategoriesModel> sub_categories,
    String code,
  ) async {
    const url = '${BASE_URL}technicans/sign-up';
    final request = http.MultipartRequest('POST', Uri.parse(url));
    request.headers['Accept'] = 'application/json';
    request.fields['name'] = name;
    request.fields['email'] = email;
    request.fields['password'] = password;
    request.fields['city'] = city;
    request.fields['phone'] = phone;
    request.fields['latitude'] = latitude.toString();
    request.fields['longitude'] = longitude.toString();

    // residency_photo
    var stream =
        http.ByteStream(DelegatingStream.typed(residency_photo.openRead()));
    var length = await residency_photo.length();
    var multipartFile = http.MultipartFile('residency_photo', stream, length,
        filename: 'residency_photo.png');
    request.files.add(multipartFile);

    // photo
    var stream1 = http.ByteStream(DelegatingStream.typed(photo.openRead()));
    var length1 = await photo.length();

    var multipartFile1 =
        http.MultipartFile('photo', stream1, length1, filename: 'photo.png');
    request.files.add(multipartFile1);

    request.fields['bank_name'] = bank_name;
    request.fields['iban'] = iban;
    request.fields['sub_categories[0]'] = sub_categories[0].id.toString();
    request.fields['code'] = '4528';
    final response = await request.send();
    print(response.statusCode);
    if (response.statusCode == 200) {
      EasyLoading.showSuccess('done...',
          maskType: EasyLoadingMaskType.black,
          duration: const Duration(milliseconds: 500));
    } else {
      EasyLoading.showError(
        "Wrong login",
        maskType: EasyLoadingMaskType.black,
      );
      final responseBody = await response.stream.bytesToString();
      print("Failed Registration: $responseBody");
      throw Exception('Failed Registration');
    }
  }
}
