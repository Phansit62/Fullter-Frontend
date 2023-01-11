// ignore_for_file: file_names

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:project/Models/FoodModel.dart';
import 'package:project/Models/OptionModel.dart' as optionModel;
import 'package:project/constants/api.dart';

class OptionsService {
  OptionsService._internal();
  static final OptionsService _instance = OptionsService._internal();
  factory OptionsService() => _instance;

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

  Future<List<optionModel.Options>> getOptions() async {
    var url = API.Option;
    var response = await dio.get(url);
    var data = optionModel.optionsFromJson(json.encode(response.data));
    return data;
  }

  Future<String> addOption(
      optionModel.Options option, List<dynamic>? data) async {
    var url = API.Option;
    FormData formdata = new FormData.fromMap({
      'titlename': option.titlename,
      'optiondetail': data,
    });
    final Response response = await dio.post(url, data: formdata);
    var statusCode = response.data["statusCode"];
    return statusCode;
  }

  Future<String> editOption(
      optionModel.Options option, List<dynamic>? data) async {
    var url = API.Option;

    FormData formdata = new FormData.fromMap({
      'optionsId': option.optionsId,
      'titlename': option.titlename,
      if (data != null) 'od': data,
    });
    final Response response = await dio.put(url, data: formdata);
    var statusCode = response.data["statusCode"];
    return statusCode;
  }

  Future<String> deleteOption(int id) async {
    var url = '${API.Option}/$id';
    final Response response = await dio.delete(url);
    var statusCode = response.data["statusCode"];
    return statusCode;
  }

  Future<String> deleteeOptionDetail(int id) async {
    var url = '${API.Option}DeleteeOptionDetail/$id';
    final Response response = await dio.delete(url, data: id);
    var statusCode = response.data["statusCode"];
    return statusCode;
  }

  Future<String> UpdateOptionDetail(OptionsDetail option) async {
    var url = '${API.Option}/UpdateOptionDetail';
    FormData formdata = new FormData.fromMap({
      'optionsId': option.optionsId,
      'optionsDetailId': option.optionsDetailId,
      'typename': option.typename,
    });
    final Response response = await dio.put(url, data: formdata);
    var statusCode = response.data["statusCode"];
    return statusCode;
  }
}
