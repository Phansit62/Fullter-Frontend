// ignore_for_file: file_names
import 'package:advance_notification/advance_notification.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:project/Models/OptionModel.dart' as optionModel;
import 'package:project/constants/api.dart';
import 'package:project/services/OptionsService.dart';

class AddOption extends StatefulWidget {
  const AddOption({Key? key}) : super(key: key);

  @override
  State<AddOption> createState() => _AddOptionState();
}

class _AddOptionState extends State<AddOption> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  optionModel.Options options = optionModel.Options();
  List<dynamic> _optionslist = [];
  String chosen = "";

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black54,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Divider(
            thickness: 3,
            indent: 150,
            endIndent: 150,
            color: Color(0xFF465056),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(26, 0, 16, 12),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  margin: EdgeInsets.only(right: 10, top: 10),
                  width: 350,
                  child: Text(
                    'เพิ่มตัวเลือกอาหาร',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          _form(),
        ],
      ),
    );
  }

  Widget _form() {
    return SizedBox(
      height: 450,
      width: MediaQuery.of(context).size.width,
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(16),
              child: TextFormField(
                initialValue: options.titlename,
                decoration: InputDecoration(
                  labelText: 'หัวข้อตัวเลือกอาหาร',
                  labelStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
                onSaved: (String? value) {
                  options.titlename = value!;
                },
                validator: (String? value) {
                  return (value!.isEmpty) ? 'กรุณากรอกข้อมูล' : null;
                },
              ),
            ),
            ListView(
              shrinkWrap: true,
              children: [
                Container(
                  margin: EdgeInsets.all(16),
                  child: TextFormField(
                    initialValue: chosen,
                    decoration: InputDecoration(
                      labelText: 'ชื่อตัวเลือก',
                      labelStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                    onChanged: (String? value) {
                      chosen = value!;
                    },
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: _optionslist.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      margin: EdgeInsets.only(left: 20, right: 20, top: 10),
                      child: Text(
                        _optionslist[index],
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                        ),
                      ),
                    );
                  },
                ),
                Container(
                  child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _optionslist.add(chosen);
                          print(_optionslist);
                        });
                      },
                      style: ElevatedButton.styleFrom(
                          primary: Color(0xffd17842),
                          textStyle: TextStyle(
                              fontSize: 20,
                              fontFamily: 'Kanit',
                              fontWeight: FontWeight.bold)),
                      child: Text('เพิ่ม')),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 160,
                  height: 50,
                  margin: EdgeInsets.only(left: 16, right: 16),
                  child: ElevatedButton(
                      onPressed: () {
                        if (!_formKey.currentState!.validate()) return;
                        _formKey.currentState!.save();
                        FocusScope.of(context).requestFocus(FocusNode());
                        OptionsService()
                            .addOption(options, _optionslist)
                            .then((value) => _Alet(value))
                            .onError((error, stackTrace) =>
                                print((error as DioError).message));
                        ;
                      },
                      style: ElevatedButton.styleFrom(
                          primary: Color(0xffd17842),
                          textStyle: TextStyle(
                              fontSize: 20,
                              fontFamily: 'Kanit',
                              fontWeight: FontWeight.bold)),
                      child: Text('บันทึก')),
                ),
                Container(
                  width: 160,
                  height: 50,
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                          primary: Colors.black54,
                          textStyle: TextStyle(
                              fontSize: 20,
                              fontFamily: 'Kanit',
                              fontWeight: FontWeight.bold)),
                      child: Text(
                        'ยกเลิก',
                      )),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  _Alet(String value) async {
    if (value == API.statucode) {
      Navigator.pop(context);
      return AdvanceSnackBar(
        message: "บันทึกข้อมูลเรียบร้อย",
        mode: Mode.ADVANCE,
        duration: Duration(seconds: 5),
      ).show(context);
    }
  }
}
