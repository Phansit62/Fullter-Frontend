import 'dart:convert';

List<Customers> customersFromJson(String str) =>
    List<Customers>.from(json.decode(str).map((x) => Customers.fromJson(x)));

String customersToJson(List<Customers> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Customers {
  Customers({
    this.cusId = 0,
    this.username = "",
    this.password = "",
    this.telephone = "",
    this.name = "",
    this.ordersDelivery = const [],
  });

  int cusId;
  String username;
  String password;
  String telephone;
  String name;
  List<dynamic> ordersDelivery;

  factory Customers.fromJson(Map<String, dynamic> json) => Customers(
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
        "ordersDelivery": List<dynamic>.from(ordersDelivery.map((x) => x)),
      };
}
