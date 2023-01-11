// ignore_for_file: file_names
// To parse this JSON data, do
//
//     final foods = foodsFromJson(jsonString);

import 'dart:convert';

import 'package:project/Models/Foodoptions.dart';

List<Foods> foodsFromJson(String str) =>
    List<Foods>.from(json.decode(str).map((x) => Foods.fromJson(x)));

String foodsToJson(List<Foods> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Catefood {
  Catefood({
    this.categoryFoodId,
    this.typeFood,
    this.foods,
  });

  int? categoryFoodId;
  String? typeFood;
  List<Foods>? foods;

  factory Catefood.fromJson(Map<String, dynamic> json) => Catefood(
        categoryFoodId: json["categoryFoodId"],
        typeFood: json["typeFood"],
        foods: List<Foods>.from(json["foods"].map((x) => Foods.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "categoryFoodId": categoryFoodId,
        "typeFood": typeFood,
        "foods": List<dynamic>.from(foods!.map((x) => x.toJson())),
      };
}

class Foods {
  Foods({
    this.foodId,
    this.name,
    this.price,
    this.status,
    this.catefoodId,
    this.description,
    this.catefood,
    this.imageFood,
    this.oderDetail,
    this.foodOptions,
  });

  int? foodId;
  String? name;
  int? price;
  bool? status;
  int? catefoodId;
  String? description;
  Catefood? catefood;
  List<ImageFood>? imageFood;
  List<dynamic>? oderDetail;
  List<FoodOptions>? foodOptions;

  factory Foods.fromJson(Map<String, dynamic> json) => Foods(
        foodId: json["foodId"] == null ? null : json["foodId"],
        name: json["name"] == null ? null : json["name"],
        price: json["price"] == null ? null : json["price"],
        status: json["status"] == null ? null : json["status"],
        catefoodId: json["catefoodId"] == null ? null : json["catefoodId"],
        description: json["description"] == null ? null : json["description"],
        catefood: json["catefood"] == null
            ? null
            : Catefood.fromJson(json["catefood"]),
        imageFood: json["imageFood"] == null
            ? null
            : List<ImageFood>.from(
                json["imageFood"].map((x) => ImageFood.fromJson(x))),
        oderDetail: json["oderDetail"] == null
            ? null
            : List<dynamic>.from(json["oderDetail"].map((x) => x)),
        foodOptions: json["foodOptions"] == null
            ? null
            : List<FoodOptions>.from(
                json["foodOptions"].map((x) => FoodOptions.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "foodId": foodId == null ? null : foodId,
        "name": name == null ? null : name,
        "price": price == null ? null : price,
        "status": status == null ? null : status,
        "catefoodId": catefoodId == null ? null : catefoodId,
        "description": description == null ? null : description,
        "catefood": catefood == null ? null : catefood!.toJson(),
        "imageFood": imageFood == null
            ? null
            : List<dynamic>.from(imageFood!.map((x) => x.toJson())),
        "oderDetail": oderDetail == null
            ? null
            : List<dynamic>.from(oderDetail!.map((x) => x)),
        "foodOptions": foodOptions == null
            ? null
            : List<FoodOptions>.from(foodOptions!.map((x) => x.toJson())),
      };
}

class ImageFood {
  ImageFood({
    this.imageId,
    this.path,
    this.foodId,
  });

  int? imageId;
  String? path;
  int? foodId;

  factory ImageFood.fromJson(Map<String, dynamic> json) => ImageFood(
        imageId: json["imageId"],
        path: json["path"],
        foodId: json["foodId"],
      );

  Map<String, dynamic> toJson() => {
        "imageId": imageId,
        "path": path,
        "foodId": foodId,
      };
}

class Option {
  Option({
    this.optionsId,
    this.titlename,
    this.foodId,
    this.details,
    this.optionsDetail,
  });

  int? optionsId;
  String? titlename;
  int? foodId;
  List<dynamic>? details;
  List<OptionsDetail>? optionsDetail;

  factory Option.fromJson(Map<String, dynamic> json) => Option(
        optionsId: json["optionsId"],
        titlename: json["titlename"],
        foodId: json["foodId"],
        details: List<dynamic>.from(json["details"].map((x) => x)),
        optionsDetail: List<OptionsDetail>.from(
            json["optionsDetail"].map((x) => OptionsDetail.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "optionsId": optionsId,
        "titlename": titlename,
        "foodId": foodId,
        "details": List<dynamic>.from(details!.map((x) => x)),
        "optionsDetail":
            List<dynamic>.from(optionsDetail!.map((x) => x.toJson())),
      };
}

class OptionsDetail {
  OptionsDetail({
    this.optionsDetailId,
    this.optionsId,
    this.typename,
    this.status,
    this.details,
  });

  int? optionsDetailId;
  int? optionsId;
  String? typename;
  bool? status;
  List<dynamic>? details;

  factory OptionsDetail.fromJson(Map<String, dynamic> json) => OptionsDetail(
        optionsDetailId: json["optionsDetailId"],
        optionsId: json["optionsId"],
        typename: json["typename"],
        status: json["status"],
        details: List<dynamic>.from(json["details"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "optionsDetailId": optionsDetailId,
        "optionsId": optionsId,
        "typename": typename,
        "status": status,
        "details": List<dynamic>.from(details!.map((x) => x)),
      };
}
