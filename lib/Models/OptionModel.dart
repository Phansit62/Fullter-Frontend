// ignore_for_file: file_names
// To parse this JSON data, do
//
//     final options = optionsFromJson(jsonString);

import 'dart:convert';

import 'package:project/Models/FoodModel.dart';

List<Options> optionsFromJson(String str) =>
    List<Options>.from(json.decode(str).map((x) => Options.fromJson(x)));

String optionsToJson(List<Options> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Options {
  Options({
    this.optionsId,
    this.titlename,
    this.optionsDetail,
  });

  int? optionsId;
  String? titlename;
  List<OptionsDetail>? optionsDetail;

  factory Options.fromJson(Map<String, dynamic> json) => Options(
        optionsId: json["optionsId"],
        titlename: json["titlename"],
        optionsDetail: List<OptionsDetail>.from(
            json["optionsDetail"].map((x) => OptionsDetail.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "optionsId": optionsId,
        "titlename": titlename,
        "optionsDetail":
            List<OptionsDetail>.from(optionsDetail!.map((x) => x.toJson())),
      };
}
