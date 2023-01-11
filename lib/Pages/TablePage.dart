// ignore_for_file: file_names

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:project/Models/TableModel.dart';
import 'package:project/services/TableService.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/api.dart';

class TablePage extends StatefulWidget {
  const TablePage({Key? key}) : super(key: key);

  @override
  State<TablePage> createState() => _TablePageState();
}

class _TablePageState extends State<TablePage> {
  Future? _getTables;
  @override
  void initState() {
    super.initState();
    _getTables = TableService().getTables();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('เลือกโต๊ะที่ต้องการ'),
        backgroundColor: Color(0xff0c0f14),
        elevation: 0,
        shadowColor: Colors.transparent,
      ),
      backgroundColor: const Color(0xff0c0f14),
      body: FutureBuilder<List<Tables>>(
          future: _getTables as Future<List<Tables>>,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var table = snapshot.data as List<Tables>;
              return RefreshIndicator(
                  onRefresh: () async {
                    setState(() {});
                  },
                  child: _gridView(table));
            }
            if (snapshot.hasError) {
              var err = (snapshot.error as DioError).message;
              return Text(err);
            }
            return Center(
                child: Lottie.asset('assets/99276-loading-utensils.json'));
          }),
    );
  }

  Widget _gridView(List<Tables> data) {
    print(data);

    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
        ),
        itemCount: data.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            color: const Color(0xff17191f),
            child: _viewTable(data[index]),
          );
        });
  }

  Future<void> sendtable(String table) async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setString(API.TableID.toString(), table);
  }

  Widget _viewTable(Tables data) {
    return GestureDetector(
      onTap: () => {
        sendtable(data.tableId.toString()),
        Navigator.pushNamed(context, '/menu', arguments: data.tableId)
            .then((value) {
          setState(() {});
        }),
      },
      child: Stack(
        fit: StackFit.expand,
        children: [
          Center(
            child: Text(
              "${data.name}",
              style: TextStyle(
                fontSize: 30,
                overflow: TextOverflow.ellipsis, //ตัดข้อความที่เกิน
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }
}
