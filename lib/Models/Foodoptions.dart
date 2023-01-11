// ignore_for_file: file_names

import 'dart:convert';

import 'package:project/Models/FoodModel.dart';

List<FoodOptions> foodOptionsFromJson(String str) => List<FoodOptions>.from(
    json.decode(str).map((x) => FoodOptions.fromJson(x)));

String foodOptionsToJson(List<FoodOptions> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FoodOptions {
  FoodOptions({
    this.foodoptionId,
    this.foodId,
    this.optionsId,
    this.options,
  });

  int? foodoptionId;
  int? foodId;
  int? optionsId;
  Options? options;

  factory FoodOptions.fromJson(Map<String, dynamic> json) => FoodOptions(
        foodoptionId: json["foodoptionId"],
        foodId: json["foodId"],
        optionsId: json["optionsId"],
        options:
            json["options"] == null ? null : Options.fromJson(json["options"]),
      );

  Map<String, dynamic> toJson() => {
        "foodoptionId": foodoptionId,
        "foodId": foodId,
        "optionsId": optionsId,
        "options": options == null ? null : options!.toJson(),
      };
}

class Options {
  Options({
    this.optionsId,
    this.titlename,
    this.details,
    this.foodOptions,
    this.optionsDetail,
  });

  int? optionsId;
  String? titlename;
  List<dynamic>? details;
  List<FoodOptions>? foodOptions;
  List<OptionsDetail>? optionsDetail;

  factory Options.fromJson(Map<String, dynamic> json) => Options(
        optionsId: json["optionsId"],
        titlename: json["titlename"],
        details: List<dynamic>.from(json["details"].map((x) => x)),
        foodOptions: List<FoodOptions>.from(json["foodOptions"].map((x) => x)),
        optionsDetail: List<OptionsDetail>.from(
            json["optionsDetail"].map((x) => OptionsDetail.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "optionsId": optionsId,
        "titlename": titlename,
        "details": List<dynamic>.from(details!.map((x) => x)),
        "foodOptions": List<dynamic>.from(foodOptions!.map((x) => x)),
        "optionsDetail":
            List<dynamic>.from(optionsDetail!.map((x) => x.toJson())),
      };
}
