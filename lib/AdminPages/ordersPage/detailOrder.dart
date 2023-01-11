// ignore_for_file: file_names, prefer_const_constructors

import 'dart:io';

import 'package:advance_notification/advance_notification.dart';
import 'package:flutter/material.dart';
import 'package:project/Models/OrdersModel.dart';
import 'package:project/constants/api.dart';
import 'package:project/services/OrderService.dart';

class DetailOrder extends StatefulWidget {
  DetailOrder({Key? key, required this.order}) : super(key: key);

  Orders order = Orders();
  @override
  State<DetailOrder> createState() => _DetailOrderState();
}

class _DetailOrderState extends State<DetailOrder> {
  @override
  Widget build(BuildContext context) {
    print(widget.order.statusId);
    return Scaffold(
      backgroundColor: Color(0xff0c0f14),
      body: SafeArea(
          child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 20),
              height: MediaQuery.of(context).size.height * 0.1,
              width: MediaQuery.of(context).size.width,
              child: Text(
                'หมายเลขการสั่งซื้อ: #${widget.order.orderId}',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'สถานะคำสั่งซื้อ',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    '${widget.order.status!.name}',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                ]),
            Container(
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Color(0xff17191f),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              width: double.infinity,
              height: 250,
              child: Container(
                margin: EdgeInsets.all(10),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'สรุปรายการสั่งซื้อ',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      ListView.builder(
                          shrinkWrap: true,
                          itemCount: widget.order.oderDetail!.length,
                          itemBuilder: (context, index) {
                            var options = widget
                                .order.oderDetail![index].detailsNavigation;
                            return Container(
                              margin: EdgeInsets.only(top: 10),
                              child: Column(
                                children: [
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          '${widget.order.oderDetail![index].food!['name']}',
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                        Text(
                                          '${widget.order.oderDetail![index].food!['price']}',
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ]),
                                  ListView.builder(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount: options!.length,
                                    itemBuilder:
                                        (BuildContext context, int index2) {
                                      return Container(
                                        margin: EdgeInsets.only(left: 13),
                                        child: Row(
                                          children: [
                                            Text(
                                              '- ${options[index2].options!.titlename}:',
                                              style: TextStyle(
                                                fontSize: 16.0,
                                                color: Colors.white,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              '${options[index2].optionsDetail!.typename}',
                                              style: TextStyle(
                                                fontSize: 16.0,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            );
                          }),
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        height: 60,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                'ราคารวม',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.green,
                                ),
                                child: Text(
                                  '฿${widget.order.total}',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                            ]),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              width: 350,
              margin: EdgeInsets.all(16),
              child: _ShowImage(),
            ),
          ],
        ),
      )),
      bottomNavigationBar: widget.order.statusId != 1 ? null : _bottom(),
    );
  }

  Widget _bottom() => SizedBox(
      height: 50,
      child: Container(
          color: Color(0xff0cf14),
          child: Container(
              width: double.infinity,
              margin: EdgeInsets.only(left: 10, right: 10),
              child: ElevatedButton(
                  onPressed: () => {
                        OrderService()
                            .ConfirmOrder(widget.order.payments!
                                .map((e) => e.paymentId)
                                .toList()[0]
                                .toString())
                            .then((value) => {_Alet(value)}),
                      },
                  style: ElevatedButton.styleFrom(
                    textStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontFamily: 'Kanit',
                      fontWeight: FontWeight.bold,
                    ),
                    primary: Color(0xffd17842),
                  ),
                  child: Text('ยืนยันการชำระเงิน')))));

  Widget _ShowImage() {
    return Container(
        child: Container(
      margin: EdgeInsets.all(10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.network(
          '${API.BASE_URL}${widget.order.payments!.map((e) => e.image).toList()[0]}',
          fit: BoxFit.cover,
          width: 100,
        ),
      ),
    ));
  }

  _Alet(String value) async {
    if (value == API.statucode) {
      Navigator.pop(context);
      return AdvanceSnackBar(
        message: "แก้ไขสถานะสำเร็จ",
        mode: Mode.ADVANCE,
        duration: Duration(seconds: 5),
      ).show(context);
    }
  }
}
