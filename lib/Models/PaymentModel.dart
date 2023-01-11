// To parse this JSON data, do
//
//     final payments = paymentsFromJson(jsonString);

// ignore_for_file: file_names

import 'dart:convert';

List<Payments> paymentsFromJson(String str) =>
    List<Payments>.from(json.decode(str).map((x) => Payments.fromJson(x)));

String paymentsToJson(List<Payments> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Payments {
  Payments({
    this.paymentId,
    this.orderId,
    this.dateIn,
    this.image,
    this.status,
    this.orderDeliveryId,
    this.order,
    this.orderDelivery,
  });

  int? paymentId;
  int? orderId;
  DateTime? dateIn;
  String? image;
  bool? status;
  int? orderDeliveryId;
  Order? order;
  dynamic? orderDelivery;

  factory Payments.fromJson(Map<String, dynamic> json) => Payments(
        paymentId: json["paymentId"],
        orderId: json["orderId"] == null ? null : json["orderId"],
        dateIn: DateTime.parse(json["dateIn"]),
        image: json["image"],
        status: json["status"],
        orderDeliveryId:
            json["orderDeliveryId"] == null ? null : json["orderDeliveryId"],
        order: json["order"] == null ? null : Order.fromJson(json["order"]),
        orderDelivery: json["orderDelivery"],
      );

  Map<String, dynamic> toJson() => {
        "paymentId": paymentId,
        "orderId": orderId == null ? null : orderId,
        "dateIn": dateIn!.toIso8601String(),
        "image": image,
        "status": status,
        "orderDeliveryId": orderDeliveryId == null ? null : orderDeliveryId,
        "order": order == null ? null : order!.toJson(),
        "orderDelivery": orderDelivery,
      };
}

class Order {
  Order({
    this.orderId,
    this.dateIn,
    this.tableId,
    this.total,
    this.statusId,
    this.status,
    this.table,
    this.oderDetail,
    this.payments,
  });

  int? orderId;
  DateTime? dateIn;
  int? tableId;
  int? total;
  int? statusId;
  dynamic? status;
  dynamic? table;
  List<OderDetail>? oderDetail;
  List<dynamic>? payments;

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        orderId: json["orderId"],
        dateIn: DateTime.parse(json["dateIn"]),
        tableId: json["tableId"],
        total: json["total"],
        statusId: json["statusId"],
        status: json["status"],
        table: json["table"],
        oderDetail: List<OderDetail>.from(
            json["oderDetail"].map((x) => OderDetail.fromJson(x))),
        payments: List<dynamic>.from(json["payments"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "orderId": orderId,
        "dateIn": dateIn!.toIso8601String(),
        "tableId": tableId,
        "total": total,
        "statusId": statusId,
        "status": status,
        "table": table,
        "oderDetail": List<dynamic>.from(oderDetail!.map((x) => x.toJson())),
        "payments": List<dynamic>.from(payments!.map((x) => x)),
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
  List<dynamic>? detailsNavigation;

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
        detailsNavigation:
            List<dynamic>.from(json["detailsNavigation"].map((x) => x)),
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
            List<dynamic>.from(detailsNavigation!.map((x) => x)),
      };
}
