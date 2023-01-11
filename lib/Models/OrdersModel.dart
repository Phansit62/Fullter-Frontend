// ignore_for_file: file_names
// To parse this JSON data, do
//
//     final orders = ordersFromJson(jsonString);

import 'dart:convert';

import 'package:project/Models/FoodModel.dart';
import 'package:project/Models/TableModel.dart';

List<Orders> ordersFromJson(String str) =>
    List<Orders>.from(json.decode(str).map((x) => Orders.fromJson(x)));

String ordersToJson(List<Orders> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Orders {
  Orders({
    this.orderId,
    this.dateIn,
    this.tableId,
    this.total,
    this.table,
    this.oderDetail,
    this.payments,
    this.statusId,
    this.status,
  });

  int? orderId;
  DateTime? dateIn;
  int? tableId;
  int? total;
  Tables? table;
  int? statusId;
  Status? status;
  List<OderDetail>? oderDetail;
  List<Payment>? payments;

  factory Orders.fromJson(Map<String, dynamic> json) => Orders(
        orderId: json["orderId"],
        dateIn: DateTime.parse(json["dateIn"]),
        tableId: json["tableId"],
        total: json["total"],
        table: json["table"],
        statusId: json["statusId"],
        status: Status.fromJson(json["status"]),
        oderDetail: List<OderDetail>.from(
            json["oderDetail"].map((x) => OderDetail.fromJson(x))),
        payments: List<Payment>.from(
            json["payments"].map((x) => Payment.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "orderId": orderId,
        "dateIn": dateIn!.toIso8601String(),
        "tableId": tableId,
        "total": total,
        "table": table,
        "statusId": statusId,
        "status": status!.toJson(),
        "oderDetail": List<dynamic>.from(oderDetail!.map((x) => x.toJson())),
        "payments": List<dynamic>.from(payments!.map((x) => x.toJson())),
      };
}

class OderDetail {
  OderDetail({
    this.orderdetailId,
    this.orderId,
    this.foodId,
    this.quantity,
    this.total,
    this.details,
    this.orderdeliveryId,
    this.food,
    this.orderdelivery,
    this.detailsNavigation,
  });

  int? orderdetailId;
  int? orderId;
  int? foodId;
  int? quantity;
  int? total;
  dynamic? details;
  dynamic? orderdeliveryId;
  dynamic? food;
  dynamic? orderdelivery;
  List<DetailsNavigation>? detailsNavigation;

  factory OderDetail.fromJson(Map<String, dynamic> json) => OderDetail(
        orderdetailId: json["orderdetailId"],
        orderId: json["orderId"],
        foodId: json["foodId"],
        quantity: json["quantity"],
        total: json["total"],
        details: json["details"],
        orderdeliveryId: json["orderdeliveryId"],
        food: json["food"],
        orderdelivery: json["orderdelivery"],
        detailsNavigation: List<DetailsNavigation>.from(
            json["detailsNavigation"]
                .map((x) => DetailsNavigation.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "orderdetailId": orderdetailId,
        "orderId": orderId,
        "foodId": foodId,
        "quantity": quantity,
        "total": total,
        "details": details,
        "orderdeliveryId": orderdeliveryId,
        "food": food,
        "orderdelivery": orderdelivery,
        "detailsNavigation":
            List<dynamic>.from(detailsNavigation!.map((x) => x.toJson())),
      };
}

class DetailsNavigation {
  DetailsNavigation({
    this.detailId,
    this.orderDetailId,
    this.optionsId,
    this.optionsDetailId,
    this.options,
    this.optionsDetail,
  });

  int? detailId;
  int? orderDetailId;
  int? optionsId;
  int? optionsDetailId;
  Options? options;
  OptionsDetail? optionsDetail;

  factory DetailsNavigation.fromJson(Map<String, dynamic> json) =>
      DetailsNavigation(
        detailId: json["detailId"],
        orderDetailId: json["orderDetailId"],
        optionsId: json["optionsId"],
        optionsDetailId: json["optionsDetailId"],
        options: Options.fromJson(json["options"]),
        optionsDetail: OptionsDetail.fromJson(json["optionsDetail"]),
      );

  Map<String, dynamic> toJson() => {
        "detailId": detailId,
        "orderDetailId": orderDetailId,
        "optionsId": optionsId,
        "optionsDetailId": optionsDetailId,
        "options": options!.toJson(),
        "optionsDetail": optionsDetail!.toJson(),
      };
}

class OptionsDetail {
  OptionsDetail({
    this.optionsDetailId,
    this.optionsId,
    this.typename,
    this.status,
    this.details,
    this.options,
  });

  int? optionsDetailId;
  int? optionsId;
  String? typename;
  bool? status;
  List<dynamic>? details;
  Options? options;

  factory OptionsDetail.fromJson(Map<String, dynamic> json) => OptionsDetail(
        optionsDetailId: json["optionsDetailId"],
        optionsId: json["optionsId"],
        typename: json["typename"],
        status: json["status"],
        details: List<dynamic>.from(json["details"].map((x) => x)),
        options:
            json["options"] == null ? null : Options.fromJson(json["options"]),
      );

  Map<String, dynamic> toJson() => {
        "optionsDetailId": optionsDetailId,
        "optionsId": optionsId,
        "typename": typename,
        "status": status,
        "details": List<dynamic>.from(details!.map((x) => x)),
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
  List<dynamic>? foodOptions;
  List<OptionsDetail>? optionsDetail;

  factory Options.fromJson(Map<String, dynamic> json) => Options(
        optionsId: json["optionsId"],
        titlename: json["titlename"],
        details: List<dynamic>.from(json["details"].map((x) => x)),
        foodOptions: List<dynamic>.from(json["foodOptions"].map((x) => x)),
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

class Payment {
  Payment({
    this.paymentId,
    this.orderId,
    this.dateIn,
    this.image,
    this.status,
    this.orderDeliveryId,
    this.orderDelivery,
  });

  int? paymentId;
  int? orderId;
  DateTime? dateIn;
  String? image;
  dynamic? status;
  dynamic orderDeliveryId;
  dynamic orderDelivery;

  factory Payment.fromJson(Map<String, dynamic> json) => Payment(
        paymentId: json["paymentId"],
        orderId: json["orderId"],
        dateIn: DateTime.parse(json["dateIn"]),
        image: json["image"],
        status: json["status"],
        orderDeliveryId: json["orderDeliveryId"],
        orderDelivery: json["orderDelivery"],
      );

  Map<String, dynamic> toJson() => {
        "paymentId": paymentId,
        "orderId": orderId,
        "dateIn": dateIn!.toIso8601String(),
        "image": image,
        "status": status,
        "orderDeliveryId": orderDeliveryId,
        "orderDelivery": orderDelivery,
      };
}

class Status {
  Status({
    this.statusId,
    this.name,
    this.orders,
  });

  int? statusId;
  String? name;
  List<dynamic>? orders;

  factory Status.fromJson(Map<String, dynamic> json) => Status(
        statusId: json["statusId"],
        name: json["name"],
        orders: List<dynamic>.from(json["orders"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "statusId": statusId,
        "name": name,
        "orders": List<dynamic>.from(orders!.map((x) => x)),
      };
}
