import 'dart:convert';

import 'package:test_baraa/core/core.dart';
import 'package:test_baraa/model/sub_categories_model.dart';
import 'package:http/http.dart' as http;

class ApiSubCategory{
  static Future<List<SubCategoriesModel>> getSubCategories(int id) async {
    final response = await http.get(
      Uri.parse('${BASE_URL}categories/$id}'),
      headers: {'Accept': 'application/json'},
    );
    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body)['data'];
      return jsonData
          .map((categoryJson) => SubCategoriesModel.fromJson(categoryJson))
          .toList();
    } else {
      throw Exception('Failed to fetch sub categories');
    }
  }
}