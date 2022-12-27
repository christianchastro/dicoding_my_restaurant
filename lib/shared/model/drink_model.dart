class DrinkModel {
  final String name;
  const DrinkModel({
    required this.name,
  });

  factory DrinkModel.fromJson(Map<String, dynamic> json) => DrinkModel(
        name: json["name"] as String,
      );

  Map<String, dynamic> toJson() => {
        "name": name,
      };
}
