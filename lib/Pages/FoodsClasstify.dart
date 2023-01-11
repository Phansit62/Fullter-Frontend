// ignore_for_file: file_names

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:project/Models/FoodModel.dart';
import 'package:project/constants/api.dart';
import 'package:project/services/FoodService.dart';

class FoodsClasstify extends StatefulWidget {
  const FoodsClasstify({Key? key}) : super(key: key);

  @override
  _FoodsClasstifyState createState() => _FoodsClasstifyState();
}

class _FoodsClasstifyState extends State<FoodsClasstify> {
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
        ],
      ),
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xff0c0f14),
      body: FutureBuilder<List<Foods>>(
          future: FoodService().getFoods(),
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
              return Text(err);
            }
            return const CircularProgressIndicator();
          }),
    );
  }

  Widget _gridView(List<Foods> data) {
    return GridView.builder(
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 5,
          childAspectRatio: 1.0,
          crossAxisSpacing: 10,
        ),
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: data.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            child: CardProductExample(data[index]),
          );
        });
  }

  Widget CardProductExample(Foods data) {
    return Container(
        decoration: BoxDecoration(
          color: Color(0xff17191f),
          borderRadius: BorderRadius.circular(20),
        ),
        padding: EdgeInsets.all(10),
        margin: const EdgeInsets.all(15),
        child: Column(
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
            SizedBox(height: 10),
            Container(
                width: 150,
                child: Column(
                  children: [
                    Text(
                      data.name!,
                      style: TextStyle(
                          fontSize: 20,
                          color: Color(0xffaeaeae),
                          fontFamily: 'Kanit',
                          fontWeight: FontWeight.bold),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                        IconButton(
                          icon: Icon(Icons.add_box,
                              color: Color(0xffd17842), size: 44),
                          onPressed: () {
                            Navigator.pushNamed(context, '/detail');
                          },
                        )
                      ],
                    )
                  ],
                )),
          ],
        ));
  }
}
