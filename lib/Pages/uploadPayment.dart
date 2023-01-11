// ignore: file_names
// ignore_for_file: file_names
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project/constants/api.dart';
import 'package:project/services/PaymentService.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UploadPayment extends StatefulWidget {
  UploadPayment({Key? key, required this.ordersId}) : super(key: key);

  var ordersId;
  @override
  State<UploadPayment> createState() => _UploadPaymentState();
}

class _UploadPaymentState extends State<UploadPayment> {
  ImagePicker _picker = ImagePicker();
  File _imageFile = File('');
  @override
  Widget build(BuildContext context) {
    return Container(
        child: SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 20),
            child: Text('คิวอาร์โค้ดสำหรับการชำระเงิน',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
          ),
          Container(
            width: 350,
            margin: EdgeInsets.all(16),
            child: _imageFile.path.isEmpty
                ? Image.asset('images/pay.jpg',
                    width: MediaQuery.of(context).size.width)
                : _ShowImage(),
          ),
          _buttonUpload(),
        ],
      ),
    ));
  }

  Widget _ShowImage() {
    return _imageFile.path.isEmpty
        ? Text('ไม่มีรูปภาพ',
            style: TextStyle(fontSize: 20, color: Colors.white))
        : Container(
            child: Container(
            margin: EdgeInsets.all(10),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.file(
                File(_imageFile.path),
                fit: BoxFit.cover,
                width: 100,
              ),
            ),
          ));
  }

  Widget _buttonUpload() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 160,
            height: 50,
            child: ElevatedButton(
                onPressed: () async {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  var id = prefs.getString(API.USERID);
                  if (_imageFile.path.isNotEmpty) {
                    if (id != '') {
                      await PaymentService()
                          .uploadImage(widget.ordersId, _imageFile)
                          .then((value) => {
                                if (value == API.statucode)
                                  {Navigator.pushNamed(context, '/complete')}
                              });
                    } else {
                      await PaymentService()
                          .updateImage(widget.ordersId, _imageFile)
                          .then((value) => {
                                if (value == API.statucode)
                                  {Navigator.pushNamed(context, '/complete')}
                              });
                    }
                  }
                  _selectImage();
                },
                style: ElevatedButton.styleFrom(
                    primary: Color(0xffd17842),
                    textStyle: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Kanit',
                        fontWeight: FontWeight.bold)),
                child: _imageFile.path.isEmpty
                    ? Text('อัพโหลดรูปภาพ')
                    : Text('ยืนยัน')),
          ),
        ],
      ),
    );
  }

  Future<void> _selectImage() async {
    File imageSource;
    await _picker.pickImage(source: ImageSource.gallery).then((value) => {
          setState(() {
            _imageFile = File(value!.path);
          }),
        });
  }
}
