class FoodModel {
  final String name;
  const FoodModel({
    required this.name,
  });

  factory FoodModel.fromJson(Map<String, dynamic> json) => FoodModel(
        name: json["name"] as String,
      );

  Map<String, dynamic> toJson() => {
        "name": name,
      };
}
