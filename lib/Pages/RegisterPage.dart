// ignore_for_file: file_names

import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:project/Models/CustomersModel.dart';
import 'package:project/constants/api.dart';
import 'package:project/services/CusService.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:validators/validators.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var user = Customers();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff0c0f14),
      body: Container(
          padding: EdgeInsets.all(20),
          child: Center(
              child: Form(
                  key: _formKey,
                  child: ListView(
                    //mainAxisAlignment: MainAxisAlignment.center,
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      // Container(
                      //   child: Image.asset(''),
                      // ),
                      TextFormField(
                        style: TextStyle(color: Colors.white),
                        initialValue: user.name,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Color(0xff141921),
                          hintStyle: TextStyle(color: Color(0xff52555a)),
                          border: OutlineInputBorder(),
                          label: Text("ชื่อผู้รับ",
                              style: TextStyle(
                                  color: Color(0xff52555a),
                                  fontSize: 20,
                                  fontFamily: 'Kanit',
                                  fontWeight: FontWeight.bold)),
                        ),
                        onSaved: (value) {
                          user.name = value!;
                        },
                        validator: (String? value) {
                          return (value!.isEmpty)
                              ? 'กรุณากรอกชื่อผู้รับอาหาร'
                              : null;
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        style: TextStyle(color: Colors.white),
                        initialValue: user.telephone,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Color(0xff141921),
                          hintStyle: TextStyle(color: Color(0xff52555a)),
                          border: OutlineInputBorder(),
                          label: Text("เบอร์โทรศัพท์",
                              style: TextStyle(
                                  color: Color(0xff52555a),
                                  fontSize: 20,
                                  fontFamily: 'Kanit',
                                  fontWeight: FontWeight.bold)),
                        ),
                        onSaved: (value) {
                          user.telephone = value!;
                        },
                        validator: (String? value) {
                          return (value!.isEmpty)
                              ? 'กรุณากรอกเบอร์โทรศัพท์'
                              : null;
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        style: TextStyle(color: Colors.white),
                        initialValue: user.username,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Color(0xff141921),
                          hintStyle: TextStyle(color: Color(0xff52555a)),
                          border: OutlineInputBorder(),
                          label: Text("ชื่อผู้ใช้",
                              style: TextStyle(
                                  color: Color(0xff52555a),
                                  fontSize: 20,
                                  fontFamily: 'Kanit',
                                  fontWeight: FontWeight.bold)),
                        ),
                        onSaved: (value) {
                          user.username = value!;
                        },
                        validator: (String? value) {
                          return (value!.isEmpty)
                              ? 'กรุณากรอกชื่อผู้ใช้งาน'
                              : null;
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        style: TextStyle(color: Colors.white),
                        initialValue: user.password,
                        obscureText: true,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Color(0xff141921),
                          hintStyle: TextStyle(color: Color(0xff52555a)),
                          border: OutlineInputBorder(),
                          label: Text("รหัสผ่าน",
                              style: TextStyle(
                                  color: Color(0xff52555a),
                                  fontSize: 20,
                                  fontFamily: 'Kanit',
                                  fontWeight: FontWeight.bold)),
                        ),
                        onSaved: (value) {
                          user.password = value!;
                        },
                        validator: (String? value) {
                          return (value!.isEmpty) ? 'กรุณากรอกรหัสผ่าน' : null;
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                          // child: RaisedButton(
                          //   padding: EdgeInsets.symmetric(
                          //       horizontal: 100, vertical: 15),
                          //   onPressed: () {
                          //     if (!_formKey.currentState!.validate()) return;
                          //     _formKey.currentState!.save();
                          //     FocusScope.of(context).requestFocus(FocusNode());
                          //     CusService()
                          //         .Register(user)
                          //         .then((value) => _goLogin(value));
                          //   },
                          //   child: Text("สมัครสมาชิก",
                          //       style: TextStyle(
                          //           color: Colors.white,
                          //           fontSize: 20,
                          //           fontFamily: 'Kanit',
                          //           fontWeight: FontWeight.bold)),
                          //   color: Color(0xffd17842),
                          // ),
                          ),
                    ],
                  )))),
    );
  }

  _goLogin(String value) async {
    if (value == API.statucode) {
      CoolAlert.show(
        context: context,
        type: CoolAlertType.success,
        text: "สมัครสมาชิกสำเร็จ",
      );
      Navigator.pushNamed(context, '/login');
    } else {
      CoolAlert.show(
        context: context,
        type: CoolAlertType.error,
        text: "เข้าสุ่ระบบไม่สำเร็จ กรุณาลองใหม่อีกครั้ง",
      );
    }
  }
}
