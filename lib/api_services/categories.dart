import 'dart:convert';

import 'package:test_baraa/core/constant.dart';
import 'package:test_baraa/model/categories_model.dart';
import 'package:http/http.dart' as http;

class ApiCategories {
  static Future<List<CategoriesModel>> getAllCategories() async {
    final response = await http.get(
      Uri.parse('${BASE_URL}categories'),
      headers: {'Accept': 'application/json'},
    );
    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body)['data'];
      return jsonData
          .map((categoriesJson) => CategoriesModel.fromJson(categoriesJson))
          .toList();
    } else {
      throw Exception('Failed to fetch categories');
    }
  }
}
