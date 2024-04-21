// ignore_for_file: non_constant_identifier_names

class SubCategoriesModel {
  final int id;
  final String name;
  final String image;
  final String description;
  final String posted_at;

  SubCategoriesModel({
    required this.id,
    required this.name,
    required this.image,
    required this.description,
    required this.posted_at,
  });

  factory SubCategoriesModel.fromJson(Map<dynamic, dynamic> json) {
    return SubCategoriesModel(
      id: json['id'],
      image: json['image'],
      name: json['name']['ar'],
      description: json['description']['ar'],
      posted_at: json['Posted at'],
    );
  }
}
