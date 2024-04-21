// ignore_for_file: non_constant_identifier_names

class CategoriesModel {
  final int id;
  final String name;
  final String image;
  final String posted_at;

  CategoriesModel({
    required this.id,
    required this.name,
    required this.image,
    required this.posted_at,
  });

  factory CategoriesModel.fromJson(Map<dynamic, dynamic> json) {
    return CategoriesModel(
      id: json['id'],
      image: json['image'],
      name: json['name']['ar'],
      posted_at: json['Posted at'],
    );
  }
}
