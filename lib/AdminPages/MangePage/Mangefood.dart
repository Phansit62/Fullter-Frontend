// ignore_for_file: file_names

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:lottie/lottie.dart';
import 'package:project/AdminPages/foodspage/addFood.dart';
import 'package:project/AdminPages/foodspage/detailFood.dart';
import 'package:project/Models/CategoryModel.dart';
import 'package:project/Models/FoodModel.dart';
import 'package:project/constants/api.dart';
import 'package:project/services/CategoryService.dart';
import 'package:project/services/FoodService.dart';

class MangeFoods extends StatefulWidget {
  const MangeFoods({Key? key}) : super(key: key);

  @override
  State<MangeFoods> createState() => _MangeFoodsState();
}

class _MangeFoodsState extends State<MangeFoods> {
  int id = 0;
  var _selectedCategory;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Color(0xffd17842),
          child: Icon(Icons.add),
          onPressed: () => showModalBottomSheet(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.9,
            ),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20))),
            backgroundColor: Color(0xff0c0f14),
            isScrollControlled: true,
            context: context,
            builder: (context) {
              return Padding(
                padding: MediaQuery.of(context).viewInsets,
                child: Container(
                  height: 620,
                  child: AddFood(),
                ),
              );
            },
          ).then((value) => {setState(() {})}),
        ),
        backgroundColor: Color(0x1A1F24),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          centerTitle: false,
          elevation: 0,
        ),
        body: SafeArea(
          child: Column(mainAxisSize: MainAxisSize.max, children: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(26, 0, 16, 12),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 10),
                    child: Text(
                      'ข้อมูลรายการอาหาร',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                    child: FutureBuilder<List<CategoryFoods>>(
                        future: CategoryService().getCategory(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            var data = snapshot.data as List<CategoryFoods>;
                            return RefreshIndicator(
                              onRefresh: () async {
                                setState(() {});
                              },
                              child: IconButton(
                                iconSize: 26,
                                icon: Icon(Icons.filter_list,
                                    color: Colors.white),
                                onPressed: () {
                                  _selectedCategorys(data);
                                },
                              ),
                            );
                          }
                          if (snapshot.hasError) {
                            var err = (snapshot.error as DioError).message;
                            return Text(err);
                          }
                          return Center(
                            child: Lottie.asset(
                                'assets/99276-loading-utensils.json'),
                          );
                        }),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 540,
              child: FutureBuilder<List<Foods>>(
                  future: FoodService().getFoodsClasstify(id as int),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      var data = snapshot.data as List<Foods>;
                      return RefreshIndicator(
                          onRefresh: () async {
                            setState(() {});
                          },
                          child: _gridView(data));
                    }
                    if (snapshot.hasError) {
                      var err = (snapshot.error as DioError).message;
                      return Text(err);
                    }
                    return Center(
                      child: Lottie.asset('assets/99276-loading-utensils.json'),
                    );
                  }),
            ),
          ]),
        ));
  }

  Widget _gridView(List<Foods> data) {
    return ListView.builder(
        physics: BouncingScrollPhysics(),
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemCount: data.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            child: CardProductExample(data[index]),
          );
        });
  }

  Widget CardProductExample(Foods data) {
    return Slidable(
      key: Key(data.foodId.toString()),
      endActionPane: ActionPane(
        motion: BehindMotion(),
        dismissible: DismissiblePane(
          onDismissed: () async => await FoodService()
              .deleteFood(data.foodId as int)
              .then((value) => {setState(() {})}),
        ),
        children: [],
      ),
      child: GestureDetector(
        onTap: () => showModalBottomSheet(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.9,
          ),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20))),
          backgroundColor: Color(0xff0c0f14),
          isScrollControlled: true,
          context: context,
          builder: (context) {
            return Padding(
              padding: MediaQuery.of(context).viewInsets,
              child: Container(
                height: 620,
                child: DetailFood(
                  food: data,
                ),
              ),
            );
          },
        ).then((value) => {setState(() {})}),
        child: Container(
          margin: EdgeInsets.only(left: 16, right: 16, top: 16),
          width: MediaQuery.of(context).size.width,
          height: 100,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                blurRadius: 3,
                color: Color(0x411D2429),
                offset: Offset(0, 1),
              )
            ],
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 1, 1, 1),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      '${API.BASE_URL}${data.imageFood!.where((e) => e.foodId == data.foodId).toList()[0].path}',
                      width: 70,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(8, 8, 4, 0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          data.name.toString(),
                          style: TextStyle(
                            fontFamily: 'Lexend Deca',
                            color: Color(0xFF090F13),
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0, 4, 8, 0),
                            child: Text(
                              data.description.toString(),
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontFamily: 'Lexend Deca',
                                color: Color(0xFF57636C),
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                      child: Icon(
                        Icons.chevron_right_rounded,
                        color: Color(0xFF57636C),
                        size: 24,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 4, 8),
                      child: Text(
                        '฿${data.price}',
                        textAlign: TextAlign.end,
                        style: TextStyle(
                          fontFamily: 'Lexend Deca',
                          color: Color(0xFF4B39EF),
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _selectedCategorys(List<CategoryFoods> data) {
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.8,
          child: Column(
            children: [
              Container(
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'ประเภทอาหาร',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.4,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(
                        data[index].typeFood.toString(),
                        style: TextStyle(fontSize: 18),
                      ),
                      onTap: () {
                        setState(() {
                          id = data[index].categoryFoodId as int;
                        });
                        Navigator.pop(context);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
