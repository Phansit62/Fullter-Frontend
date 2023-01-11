// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

List<Welcome> welcomeFromJson(String str) =>
    List<Welcome>.from(json.decode(str).map((x) => Welcome.fromJson(x)));

String welcomeToJson(List<Welcome> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Welcome {
  Welcome({
    this.orderDeliveryId,
    this.dateIn,
    this.cusId,
    this.total,
    this.statusdeliveryId,
    this.details,
    this.lat,
    this.long,
    this.cus,
    this.statusdelivery,
    this.oderDetail,
    this.payments,
  });

  int? orderDeliveryId;
  DateTime? dateIn;
  int? cusId;
  int? total;
  int? statusdeliveryId;
  String? details;
  String? lat;
  String? long;
  Cus? cus;
  Statusdelivery? statusdelivery;
  List<dynamic>? oderDetail;
  List<dynamic>? payments;

  factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
        orderDeliveryId: json["orderDeliveryId"],
        dateIn: json["dateIn"],
        cusId: json["cusId"],
        total: json["total"],
        statusdeliveryId: json["statusdeliveryId"],
        details: json["details"],
        lat: json["lat"],
        long: json["long"],
        cus: Cus.fromJson(json["cus"]),
        statusdelivery: Statusdelivery.fromJson(json["statusdelivery"]),
        oderDetail: List<dynamic>.from(json["oderDetail"].map((x) => x)),
        payments: List<dynamic>.from(json["payments"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "orderDeliveryId": orderDeliveryId,
        "dateIn": dateIn,
        "cusId": cusId,
        "total": total,
        "statusdeliveryId": statusdeliveryId,
        "details": details,
        "lat": lat,
        "long": long,
        "cus": cus!.toJson(),
        "statusdelivery": statusdelivery!.toJson(),
        "oderDetail": List<dynamic>.from(oderDetail!.map((x) => x)),
        "payments": List<dynamic>.from(payments!.map((x) => x)),
      };
}

class Cus {
  Cus({
    this.cusId,
    this.username,
    this.password,
    this.telephone,
    this.name,
    this.ordersDelivery,
  });

  int? cusId;
  String? username;
  String? password;
  String? telephone;
  String? name;
  List<dynamic>? ordersDelivery;

  factory Cus.fromJson(Map<String, dynamic> json) => Cus(
        cusId: json["cusId"],
        username: json["username"],
        password: json["password"],
        telephone: json["telephone"],
        name: json["name"],
        ordersDelivery:
            List<dynamic>.from(json["ordersDelivery"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "cusId": cusId,
        "username": username,
        "password": password,
        "telephone": telephone,
        "name": name,
        "ordersDelivery": List<dynamic>.from(ordersDelivery!.map((x) => x)),
      };
}

class Statusdelivery {
  Statusdelivery({
    this.statusdeliveryId,
    this.type,
    this.ordersDelivery,
  });

  int? statusdeliveryId;
  String? type;
  List<dynamic>? ordersDelivery;

  factory Statusdelivery.fromJson(Map<String, dynamic> json) => Statusdelivery(
        statusdeliveryId: json["statusdeliveryId"],
        type: json["type"],
        ordersDelivery:
            List<dynamic>.from(json["ordersDelivery"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "statusdeliveryId": statusdeliveryId,
        "type": type,
        "ordersDelivery": List<dynamic>.from(ordersDelivery!.map((x) => x)),
      };
}
