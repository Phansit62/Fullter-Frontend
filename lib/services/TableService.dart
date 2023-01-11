// ignore_for_file: file_names
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:project/Models/TableModel.dart';
import 'package:project/constants/api.dart';

class TableService {
//สร้างออบแบบ single ton คือจองพ้ืนที่หน่วยความจา เรียบร้อยแลว้
  TableService._internal();
  static final TableService _instance = TableService._internal();
  factory TableService() => _instance;

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

  Future<List<Tables>> getTables() async {
    const url = API.Table;
    var response = await dio.get(url);
    var data = tablesFromJson(json.encode(response.data));
    return data;
  }
}
