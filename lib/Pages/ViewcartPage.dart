// ignore_for_file: file_names

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:project/Models/OptionModel.dart';
import 'package:project/constants/cart.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:project/services/OrderService.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/api.dart';

class ViewCartPage extends StatefulWidget {
  const ViewCartPage({Key? key}) : super(key: key);

  @override
  _ViewCartPageState createState() => _ViewCartPageState();
}

final db = DatabaseHelper.instance;
int _total = 0;

class _ViewCartPageState extends State<ViewCartPage> {
  List? _cart;

  createAlertDialog(BuildContext context) {
    TextEditingController _controller = TextEditingController();

    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("กรุณาป้อนที่อยู่สำหรับจัดส่ง"),
            content: TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: "ที่อยู่",
              ),
            ),
            actions: [
              TextButton(
                child: Text("ตกลง"),
                onPressed: () {
                  OrderService()
                      .SendOrderDelivery(_cart!, _total, _controller.text)
                      .then((value) => {
                            if (value[0] == API.statucode)
                              {
                                Navigator.pushNamed(context, '/payment',
                                    arguments: [value[1], _cart!, _total])
                              }
                          });
                },
              ),
            ],
          );
        });
  }

  void getCart() async {
    var cart = await db.getCart();
    int total = await db.getTotal();
    setState(() {
      _cart = cart;
      _total = total;
    });
  }

  @override
  void initState() {
    super.initState();
    getCart();
  }

  Widget build(BuildContext context) {
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
      ),
      body: Container(
        child: _cart != null
            ? ListView.builder(
                shrinkWrap: true,
                itemCount: _cart?.length,
                itemBuilder: (BuildContext context, int index) {
                  return _cardItem(index);
                },
              )
            : Container(
                margin: EdgeInsets.only(top: 50),
                child: Lottie.asset(
                  'assets/98560-empty.json',
                ),
              ),
      ),
      bottomNavigationBar: _cart != null ? _bottomNavigationBar() : null,
    );
  }

  Widget _cardItem(int index) {
    int id = _cart![index]['id'];
    var op = json.decode(_cart?[index]['options']);
    return Slidable(
      key: ValueKey(id),
      endActionPane: ActionPane(
        motion: BehindMotion(),
        dismissible: DismissiblePane(
            onDismissed: () => {
                  delete(id),
                  Navigator.pop(context),
                }),
        children: [],
      ),
      child: Container(
        child: Card(
          color: Color(0xff17191f),
          elevation: 10.0,
          margin: EdgeInsets.all(10.0),
          child: Container(
            padding: EdgeInsets.all(10.0),
            child: Row(
              children: [
                Container(
                  height: 100.0,
                  width: 100.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    image: DecorationImage(
                      image: NetworkImage(
                        '${API.BASE_URL}' '${_cart![index]['image']}',
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(
                  width: 10.0,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            _cart![index]['name'],
                            style: TextStyle(
                              fontSize: 24.0,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                '\t\฿',
                                style: TextStyle(
                                    fontSize: 30,
                                    color: Color(0xffd17842),
                                    fontFamily: 'Kanit',
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                _cart![index]['price'],
                                style: TextStyle(
                                    fontSize: 25,
                                    color: Colors.white,
                                    fontFamily: 'Kanit',
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            'จำนวน: ${_cart![index]['quantity']}',
                            style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            width: 30,
                          ),
                          Text(
                            'รวม: \$${(_cart![index]['total'])}',
                            style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      _Listview(op),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _Listview(op) {
    return Container(
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: op.length,
        itemBuilder: (BuildContext context, int index) {
          return _cardItemOption(op, index);
        },
      ),
    );
  }

  Widget _cardItemOption(List op, int index) {
    return Container(
      child: Row(
        children: [
          Text(
            '${op[index]['odname']}',
            style: TextStyle(
              fontSize: 15.0,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            width: 5.0,
          ),
          Text(
            '${op[index]['oddname']}',
            style: TextStyle(
              fontSize: 15.0,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  void delete(int id) async {
    await db.deleteCart(id);
    getCart();
  }

  Widget _bottomNavigationBar() {
    return SizedBox(
      height: 60.0,
      child: BottomAppBar(
        elevation: 1,
        color: Color(0xff17191f),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(left: 20.0),
              child: Text(
                'รวม: \$${_total}',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ElevatedButton(
                onPressed: () async {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  var id = prefs.getString(API.USERID);
                  if (id != '') {
                    createAlertDialog(context);
                  } else {
                    Navigator.pushNamed(context, '/ConfirmOrder',
                        arguments: [_cart!, _total]);
                  }
                  await db.claerCart();
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(160, 100),
                  textStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontFamily: 'Kanit',
                    fontWeight: FontWeight.bold,
                  ),
                  primary: Color(0xffd17842),
                ),
                child: Text('ชำระเงิน'))
          ],
        ),
      ),
    );
  }

  update(int id) {
    print('update');
  }
}
