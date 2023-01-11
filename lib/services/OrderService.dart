// ignore_for_file: file_names, unnecessary_new

import 'dart:convert';
import 'dart:io';
import 'package:project/Models/OrdersModel.dart';
import 'package:project/constants/api.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderService {
  OrderService._internal();
  static final OrderService _instance = OrderService._internal();
  factory OrderService() => _instance;

  var dio = Dio()
    ..interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
      options.baseUrl = API.BASE_URL;
      return handler.next(options); //continue
    }, onResponse: (response, handler) {
      return handler.next(response); // continue
    }, onError: (DioError e, handler) {
      return handler.next(e); //continue
    }));

  Future<List<Orders>> getOrders() async {
    var url = API.Order;
    final Response response = await dio.get(url);
    var data = ordersFromJson(json.encode(response.data));
    return data;
  }

  Future<List<String>> SendOrder(List order, int total) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var id = prefs.getString(API.TableID);
    final url = API.Order;
    late Response response;
    for (var item in order) {
      FormData data = new FormData.fromMap({
        'foodId': item['foodId'],
        'quantity': item['quantity'],
        'id': id.toString(),
        'total': item['total'],
        'option': item['options'],
      });
      response = await dio.post(url, data: data);
    }
    var statusCode = response.data["statusCode"];
    return statusCode;
  }

  Future<List<String>> SendOrderDelivery(
      List order, int total, String address) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var id = prefs.getString(API.USERID);
    final url = API.Order;
    final Response createOrder = await dio.get("${url}OpenBillDelivery/${id}",
        queryParameters: {"total": total, "address": address});
    for (var item in order) {
      FormData data = new FormData.fromMap({
        'foodId': item['foodId'],
        'orderdeliveryId': createOrder.data['id'],
        'quantity': item['quantity'],
        'total': item['total'],
        'option': item['options'],
      });
      final Response response = await dio.post(url, data: data);
    }
    var statusCode = createOrder.data["statusCode"];
    return [statusCode, createOrder.data['id'].toString()];
  }

  Future<String> ConfirmOrder(String id) async {
    final url = '${API.Order}ConfirmOrder/${id}';
    final Response response = await dio.get(url);
    return response.data["statusCode"];
  }
}
