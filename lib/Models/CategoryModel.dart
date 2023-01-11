// ignore_for_file: file_names
// To parse this JSON data, do
//
//     final categoryFoods = categoryFoodsFromJson(jsonString);

import 'dart:convert';

List<CategoryFoods> categoryFoodsFromJson(String str) =>
    List<CategoryFoods>.from(
        json.decode(str).map((x) => CategoryFoods.fromJson(x)));

String categoryFoodsToJson(List<CategoryFoods> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CategoryFoods {
  CategoryFoods({
    this.categoryFoodId,
    this.typeFood,
    this.foods,
  });

  int? categoryFoodId;
  String? typeFood;
  List<dynamic>? foods;

  factory CategoryFoods.fromJson(Map<String, dynamic> json) => CategoryFoods(
        categoryFoodId: json["categoryFoodId"],
        typeFood: json["typeFood"],
        foods: List<dynamic>.from(json["foods"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "categoryFoodId": categoryFoodId,
        "typeFood": typeFood,
        "foods": List<dynamic>.from(foods!.map((x) => x)),
      };
}
