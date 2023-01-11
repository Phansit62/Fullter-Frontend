// ignore_for_file: file_names

import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:group_radio_button/group_radio_button.dart';
import 'package:project/Models/FoodModel.dart';
import 'package:project/Models/Foodoptions.dart';
import 'package:project/constants/api.dart';
import 'package:project/constants/cart.dart';

class FoodDetailPage extends StatefulWidget {
  const FoodDetailPage({Key? key}) : super(key: key);

  @override
  _FoodDetailPageState createState() => _FoodDetailPageState();
}

class _FoodDetailPageState extends State<FoodDetailPage> {
  int count = 0;
  var food = Foods();
  final db = DatabaseHelper.instance;
  var option = [];
  @override
  void initState() {
    super.initState();
    count = 1;
  }

  @override
  Widget build(BuildContext context) {
    food = ModalRoute.of(context)!.settings.arguments as Foods;

    // print(food.options[0].optionsDetail);
    return Scaffold(
        backgroundColor: Color(0xff0c0f14),
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              size: 30.0,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          backgroundColor: Color(0xff0c0f14),
          title: Padding(
            padding: const EdgeInsets.only(left: 280.0),
            child: IconButton(
              icon: Icon(
                Icons.shopping_bag,
                size: 30.0,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          elevation: 0,
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          physics: BouncingScrollPhysics(),
          child: Column(children: [
            Container(
              child: Image.network(
                  '${API.BASE_URL}${food.imageFood!.where((e) => e.foodId == food.foodId).toList()[0].path}',
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 400),
            ),
            Container(
              child: Text(
                food.name.toString(),
                style: TextStyle(
                    fontSize: 40,
                    fontFamily: 'Kanit',
                    color: Color(0xffaeaeae),
                    fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '\฿\t',
                    style: TextStyle(
                        fontSize: 40,
                        fontFamily: 'Kanit',
                        color: Color(0xffd17842),
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    food.price.toString(),
                    style: TextStyle(
                        fontSize: 35,
                        fontFamily: 'Kanit',
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              child: Text(
                'ตัวเลือกอาหาร',
                style: TextStyle(
                    fontSize: 30,
                    fontFamily: 'Kanit',
                    color: Color(0xffaeaeae),
                    fontWeight: FontWeight.bold),
              ),
            ),
            _optionsDropdown(),
          ]),
        ),
        bottomNavigationBar: _bottom());
  }

  void addCart() async {
    var price = food.price as int;
    var jsone = json.encode(option);
    Map<String, dynamic> row = {
      'id': 0,
      'foodId': food.foodId,
      'name': food.name,
      'price': food.price,
      'image': food.imageFood!
          .where((e) => e.foodId == food.foodId)
          .toList()[0]
          .path,
      'quantity': count,
      'total': count * price,
      'options': jsone,
    };
    await db.addCart(row);
  }

  Widget _optionsDropdown() {
    var data = food.foodOptions!.map((e) => e.options).toList();
    return ListView.builder(
        itemCount: data.length,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (BuildContext context, index) {
          return Container(
            margin: EdgeInsets.only(top: 20),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 20, right: 20, bottom: 10),
                  width: double.infinity,
                  height: 40,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Color(0xffd17842),
                        textStyle: TextStyle(
                            fontSize: 20,
                            fontFamily: 'Kanit',
                            fontWeight: FontWeight.bold)),
                    child: option.isNotEmpty
                        ? Container(
                            child: index < option.length
                                ? Text('${option[index]["oddname"]}')
                                : Text('เลือก ${data[index]!.titlename}'))
                        : Text('เลือก ${data[index]!.titlename}'),
                    onPressed: () {
                      _selectedCategorys(data[index] as Options);
                    },
                  ),
                ),
              ],
            ),
          );
        });
  }

  _selectedCategorys(Options data) {
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
                      '${data.titlename}',
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
                  itemCount: data.optionsDetail!.length,
                  itemBuilder: (context, index) {
                    return chosen(data.optionsDetail![index] as OptionsDetail,
                        data.titlename.toString());
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget chosen(OptionsDetail data, String titlename) => ListTile(
        title: Text(
          data.typename.toString(),
          style: TextStyle(fontSize: 18),
        ),
        onTap: () {
          int index = option
              .indexWhere((e) => e['optionsId'] == data.optionsId.toString());
          setState(() {
            index == -1
                ? option.add({
                    'optionsId': data.optionsId.toString(),
                    'odname': titlename,
                    'optionsdetailId': data.optionsDetailId.toString(),
                    'oddname': data.typename.toString(),
                  })
                : {
                    option.removeAt(index),
                    option.insert(index, {
                      'optionsId': data.optionsId.toString(),
                      'odname': titlename,
                      'optionsdetailId': data.optionsDetailId.toString(),
                      'oddname': data.typename.toString(),
                    })
                  };
            print(option);
          });
          print(option);
          Navigator.pop(context);
        },
      );

  Widget _bottom() => SizedBox(
      height: 70,
      child: Container(
          padding: const EdgeInsets.only(left: 30),
          color: Color(0xff0cf14),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Container(
                child: Row(children: [
              IconButton(
                icon: Icon(Icons.add, color: Color(0xffd17842), size: 40),
                onPressed: () {
                  setState(() {
                    count++;
                  });
                },
              ),
              SizedBox(width: 10),
              Container(
                margin: const EdgeInsets.only(top: 15),
                child: Text(count.toString(),
                    style: TextStyle(
                        fontSize: 40,
                        fontFamily: 'Kanit',
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
              ),
              IconButton(
                icon: Icon(Icons.remove, color: Color(0xffd17842), size: 40),
                onPressed: () {
                  setState(() {
                    if (count <= 0) {
                      count = 1;
                    } else
                      count--;
                  });
                },
              )
            ])),
            Container(
                width: 230,
                height: double.infinity,
                child: ElevatedButton(
                    onPressed: () {
                      addCart();
                      CoolAlert.show(
                        context: context,
                        width: 150,
                        type: CoolAlertType.success,
                        text: "เพิ่มเข้าตะกร้าสำเร็จ",
                      );
                    },
                    style: ElevatedButton.styleFrom(
                        primary: Color(0xffd17842),
                        textStyle: TextStyle(
                            fontSize: 20,
                            fontFamily: 'Kanit',
                            fontWeight: FontWeight.bold)),
                    child: Text('เพิ่มลงตะกร้า'))),
          ])));
}
