// ignore_for_file: file_names

import 'package:dio/dio.dart';
import 'package:project/Models/CategoryModel.dart';
import 'package:project/constants/api.dart';
import 'dart:convert';
import 'dart:io';

class CategoryService {
  CategoryService._internal();
  static final CategoryService _instance = CategoryService._internal();
  factory CategoryService() => _instance;

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

  Future<List<CategoryFoods>> getCategory() async {
    final url = API.Cate;
    var response = await dio.get(url);
    var data = categoryFoodsFromJson(json.encode(response.data));
    return data;
  }

  Future<String> addCategory(CategoryFoods categoryFoods) async {
    final url = API.Cate;
    FormData formData = FormData.fromMap({
      "typeFood": categoryFoods.typeFood,
    });
    var response = await dio.post(url, data: formData);
    var statusCode = response.data['statusCode'];
    return statusCode;
  }

  Future<String> editCategory(CategoryFoods categoryFoods) async {
    final url = API.Cate;
    FormData formData = FormData.fromMap({
      "categoryFoodId": categoryFoods.categoryFoodId,
      "typeFood": categoryFoods.typeFood,
    });
    var response = await dio.put(url, data: formData);
    var statusCode = response.data['statusCode'];
    return statusCode;
  }

  Future<String> deleteCategory(int id) async {
    final url = '${API.Cate}/$id';
    final Response response = await dio.delete(url);
    var statusCode = response.data['statusCode'];
    return statusCode;
  }
}
