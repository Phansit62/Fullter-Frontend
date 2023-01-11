// ignore_for_file: file_names

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:project/Models/CategoryModel.dart';
import 'package:project/Models/FoodModel.dart';
import 'package:project/constants/api.dart';
import 'package:project/services/CategoryService.dart';
import 'package:project/services/FoodService.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({Key? key}) : super(key: key);

  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  int? id;
  String? userId;
  @override
  void initState() {
    super.initState();
    id = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff0c0f14),
        shadowColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            size: 30,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.shopping_cart_outlined,
              size: 30,
            ),
            onPressed: () {
              Navigator.pushNamed(context, '/cart');
            },
          ),
          IconButton(
            icon: Icon(
              Icons.document_scanner,
              size: 30,
            ),
            onPressed: () {
              Navigator.pushNamed(context, '/');
            },
          ),
          if (userId != null)
            IconButton(
              icon: Icon(
                Icons.logout,
                size: 30,
              ),
              onPressed: () {
                _logout();
              },
            ),
        ],
      ),
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xff0c0f14),
      body: SafeArea(
          child: Container(
              child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  physics: BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 10, bottom: 10),
                        alignment: Alignment.center,
                        child: Text(
                          'เลือกอาหารที่คุณชอบ',
                          style: TextStyle(
                              fontSize: 30,
                              fontFamily: 'Kanit',
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                      Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: TextFormField(
                              style: TextStyle(
                                fontSize: 20,
                                fontFamily: 'Kanit',
                              ),
                              decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Color(0xff141921),
                                  hintText: "ค้นหาอาหาร",
                                  hintStyle:
                                      TextStyle(color: Color(0xff52555a)),
                                  prefixIcon: Icon(Icons.search,
                                      color: Color(0xff52555a)),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(20),
                                  )))),
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
                                    child: _gridViewCate(data));
                              }
                              if (snapshot.hasError) {
                                var err = (snapshot.error as DioError).message;
                                print(err);
                              }
                              return Center(
                                child: Lottie.asset(
                                    'assets/99276-loading-utensils.json'),
                              );
                            }),
                      ),
                      SizedBox(
                        height: 400,
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
                                var err = (snapshot.error).toString();
                              }
                              return Center(
                                child: Lottie.asset(
                                    'assets/99276-loading-utensils.json'),
                              );
                            }),
                      )
                    ],
                  )))),
    );
  }

  Widget _gridViewCate(List<CategoryFoods> data) {
    return ListView.builder(
        physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        scrollDirection: Axis.horizontal,
        itemCount: data.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            child: GestureDetector(
                onTap: () {
                  setState(() {
                    id = data[index].categoryFoodId;
                  });
                },
                child: Container(
                    margin: EdgeInsets.only(left: 10, right: 10),
                    padding: EdgeInsets.all(5),
                    child: Text(
                      data[index].typeFood.toString(),
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'Kanit',
                          color: Colors.white),
                    ))),
          );
        });
  }

  void _logout() async {
    var prefs = await SharedPreferences.getInstance();
    prefs.remove(API.ISLOGIN);
    Navigator.pushNamed(context, '/');
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
    return GestureDetector(
      onTap: () =>
          Navigator.pushNamed(context, '/FoodDetailPage', arguments: data)
              .then((value) {
        setState(() {});
      }),
      child: Container(
          decoration: BoxDecoration(
            color: Color(0xff17191f),
            borderRadius: BorderRadius.circular(20),
          ),
          padding: EdgeInsets.all(10),
          margin: const EdgeInsets.all(15),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 150,
                width: 150,
                child: Image.network(
                  '${API.BASE_URL}${data.imageFood!.where((e) => e.foodId == data.foodId).toList()[0].path}',
                  fit: BoxFit.fill,
                ),
              ),
              Container(
                  width: 120,
                  margin: EdgeInsets.only(left: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data.name!,
                        style: TextStyle(
                            fontSize: 26,
                            color: Color(0xffaeaeae),
                            fontFamily: 'Kanit',
                            fontWeight: FontWeight.bold),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                '\฿\t',
                                style: TextStyle(
                                    fontSize: 30,
                                    color: Color(0xffd17842),
                                    fontFamily: 'Kanit',
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                data.price.toString(),
                                style: TextStyle(
                                    fontSize: 25,
                                    color: Colors.white,
                                    fontFamily: 'Kanit',
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ],
                      )
                    ],
                  )),
            ],
          )),
    );
  }
}
