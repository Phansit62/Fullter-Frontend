// To parse this JSON data, do
//
//     final tables = tablesFromJson(jsonString);

import 'dart:convert';

List<Tables> tablesFromJson(String str) =>
    List<Tables>.from(json.decode(str).map((x) => Tables.fromJson(x)));

String tablesToJson(List<Tables> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Tables {
  Tables({
    this.tableId = 0,
    this.name = '',
    this.orders = const [],
  });

  int tableId;
  String name;
  List<dynamic> orders;

  factory Tables.fromJson(Map<String, dynamic> json) => Tables(
        tableId: json["tableId"],
        name: json["name"],
        orders: List<dynamic>.from(json["orders"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "tableId": tableId,
        "name": name,
        "orders": List<dynamic>.from(orders.map((x) => x)),
      };
}
