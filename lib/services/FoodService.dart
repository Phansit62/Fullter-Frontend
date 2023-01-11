// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project/Models/FoodModel.dart';
import 'package:project/constants/api.dart';
import 'package:dio/dio.dart';
import 'dart:convert';
import 'dart:io';

class FoodService {
  FoodService._internal();
  static final FoodService _instance = FoodService._internal();
  factory FoodService() => _instance;

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

  Future<List<Foods>> getFoods() async {
    final url = API.Food;
    var response = await dio.get(url);
    var data = foodsFromJson(json.encode(response.data));
    return data;
  }

  Future<List<Foods>> getFoodsClasstify(int id) async {
    final url = "${API.Food}ClasstifyFoods/$id";
    var response = await dio.get(url);
    var data = foodsFromJson(json.encode(response.data));
    return data;
  }

  Future<String> addFood(Foods data, List<XFile>? imageFile) async {
    final url = API.Food;
    List<dynamic>? imageFileList = [];
    if (imageFile!.isNotEmpty) {
      for (XFile image in imageFile) {
        var path = image.path;
        imageFileList.add(await MultipartFile.fromFile(path));
      }
    }

    FormData formdata = FormData.fromMap({
      'name': data.name,
      'price': data.price,
      'description': data.description,
      'catefoodId': data.catefoodId,
      if (imageFileList.isNotEmpty) 'upfile': imageFileList,
    });
    final Response response = await dio.post(url, data: formdata);
    var statusCode = response.data['statusCode'];
    return statusCode;
  }

  Future<String> updateFood(Foods data, List<XFile>? imageFile) async {
    final url = API.Food;
    List<dynamic>? imageFileList = [];
    if (imageFile!.isNotEmpty) {
      for (XFile image in imageFile) {
        var path = image.path;
        imageFileList.add(await MultipartFile.fromFile(path));
      }
    }

    FormData formdata = FormData.fromMap({
      'foodId': data.foodId,
      'name': data.name,
      'price': data.price,
      'description': data.description,
      'catefoodId': data.catefoodId,
      if (imageFileList.isNotEmpty) 'upfile': imageFileList,
    });
    final Response response = await dio.put(url, data: formdata);
    var statusCode = response.data['statusCode'];
    return statusCode;
  }

  Future<String> deleteFood(int id) async {
    final url = "${API.Food}/$id";
    final Response response = await dio.delete(url);
    var statusCode = response.data['statusCode'];
    return statusCode;
  }

  Future<String> updateImage(ImageFood imagefood, File imageFile) async {
    final url = "${API.Food}UpdateImage";
    var imageFileList = await MultipartFile.fromFile(imageFile.path);
    FormData formdata = FormData.fromMap({
      'foodId': imagefood.foodId,
      'imageId': imagefood.imageId,
      'upfile': imageFileList,
    });
    final Response response = await dio.put(url, data: formdata);
    var statusCode = response.data['statusCode'];
    return statusCode;
  }
}
