// ignore_for_file: file_names

import 'dart:convert';
import 'dart:io';
import 'package:project/Models/OrdersModel.dart';
import 'package:project/Models/PaymentModel.dart';
import 'package:project/constants/api.dart';
import 'package:dio/dio.dart';

class PaymentService {
  PaymentService._internal();
  static final PaymentService _instance = PaymentService._internal();
  factory PaymentService() => _instance;

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

  Future<List<Payments>> getPayment() async {
    final url = API.Payment;
    final Response response = await dio.get(url);
    var data = paymentsFromJson(json.encode(response.data));
    return data;
  }

  Future<String> updateImage(String id, File imageFile) async {
    final url = "${API.Payment}";
    var imageFileList = await MultipartFile.fromFile(imageFile.path);
    FormData formdata = FormData.fromMap({
      'id': id,
      'upfile': imageFileList,
    });
    final Response response = await dio.post(url, data: formdata);
    var statusCode = response.data['statusCode'];
    return statusCode;
  }

  Future<String> uploadImage(String id, File imageFile) async {
    final url = "${API.Payment}PaymentDelivery";
    var imageFileList = await MultipartFile.fromFile(imageFile.path);
    FormData formdata = FormData.fromMap({
      'id': id,
      'upfile': imageFileList,
    });
    final Response response = await dio.post(url, data: formdata);
    var statusCode = response.data['statusCode'];
    return statusCode;
  }
}
