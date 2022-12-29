class CategoryModel {
  final String name;
  const CategoryModel({
    required this.name,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        name: json["name"] as String,
      );

  Map<String, dynamic> toJson() => {
        "name": name,
      };
}
