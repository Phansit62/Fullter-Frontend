import 'dart:convert';
import 'dart:io';
import 'package:project/Models/CustomersModel.dart';
import 'package:project/constants/api.dart';
import 'package:dio/dio.dart';

class CusService {
  CusService._internal();
  static final CusService _instance = CusService._internal();
  factory CusService() => _instance;

  var dio = Dio()
    ..interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
      options.baseUrl = API.BASE_URL;
      return handler.next(options); //continue
    }, onResponse: (response, handler) {
      return handler.next(response); // continue
    }, onError: (DioError e, handler) {
      e.error = "การเชื่อมต่อของคุณมีปัญหา";
      return handler.next(e); //continue
    }));

  Future<List<Customers>> getCustomers() async {
    var url = API.User;
    var response = await dio.get(url);
    var data = customersFromJson(json.encode(response.data));
    return data;
  }

  Future<List<String>> login(Customers user) async {
    var url = API.User + 'Login';
    var data = FormData.fromMap({
      "username": user.username,
      "password": user.password,
    });
    var response = await dio.post(url, data: data);
    var msg = response.data["msg"];
    var statusCode = response.data["statusCode"];
    return [statusCode, response.data["id"].toString()];
  }

  Future<String> Register(Customers user) async {
    final url = API.User + 'Register';
    FormData data = FormData.fromMap({
      'username': user.username,
      'password': user.password,
      'telephone': user.telephone,
      'name': user.name,
    });
    String msg;
    var statusCode;
    try {
      final Response response = await dio.post(url, data: data);
      msg = response.data["msg"];
      statusCode = response.data["statusCode"];
    } catch (e) {
      msg = 'Network error';
    }
    return statusCode;
  }
}
