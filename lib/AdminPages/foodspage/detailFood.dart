// ignore_for_file: file_names
import 'dart:io';

import 'package:advance_notification/advance_notification.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project/Models/CategoryModel.dart';
import 'package:project/Models/FoodModel.dart';
import 'package:project/constants/api.dart';
import 'package:project/services/CategoryService.dart';
import 'package:project/services/FoodService.dart';

class DetailFood extends StatefulWidget {
  DetailFood({required this.food});
  Foods food = Foods();

  @override
  State<DetailFood> createState() => _DetailFoodState();
}

class _DetailFoodState extends State<DetailFood> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  ImagePicker _picker = ImagePicker();
  List<XFile> _selectedFiles = [];
  File _imageFile = File('');

  var _selectedCategory = 'เลือกประเภทอาหาร';
  @override
  void initState() {
    super.initState();
    _selectedCategory = widget.food.catefood!.typeFood as String;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black54,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 1,
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
                    'เพิ่มรายการอาหาร',
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
        height: 500,
        width: MediaQuery.of(context).size.width,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                _buttonUpload(),
                _ShowImage(_selectedFiles),
                _ShowOldImage(),
                Container(
                  margin: EdgeInsets.all(16),
                  child: TextFormField(
                    initialValue: widget.food.name,
                    decoration: InputDecoration(
                      labelText: 'ชื่ออาหาร',
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
                      widget.food.name = value!;
                    },
                    validator: (String? value) {
                      return (value!.isEmpty) ? 'กรุณากรอกข้อมูล' : null;
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(16),
                  child: TextFormField(
                    initialValue: widget.food.price.toString(),
                    decoration: InputDecoration(
                      labelText: 'ราคา',
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
                    onSaved: (newValue) =>
                        widget.food.price = int.parse(newValue!),
                    validator: (String? value) {
                      return (value!.isEmpty) ? 'กรุณากรอกข้อมูล' : null;
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(16),
                  child: TextFormField(
                    initialValue: widget.food.description,
                    decoration: InputDecoration(
                      labelText: 'รายละเอียด',
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
                      widget.food.description = value!;
                    },
                    validator: (String? value) {
                      return (value!.isEmpty) ? 'กรุณากรอกข้อมูล' : null;
                    },
                  ),
                ),
                SizedBox(
                  height: 60,
                  child: FutureBuilder<List<CategoryFoods>>(
                      future: CategoryService().getCategory(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          var data = snapshot.data as List<CategoryFoods>;
                          return RefreshIndicator(
                            onRefresh: () async {
                              setState(() {});
                            },
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: Color(0xffd17842),
                                  textStyle: TextStyle(
                                      fontSize: 20,
                                      fontFamily: 'Kanit',
                                      fontWeight: FontWeight.bold)),
                              child: Text(_selectedCategory),
                              onPressed: () {
                                _selectedCategorys(data);
                              },
                            ),
                          );
                        }
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }),
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
                            FoodService()
                                .updateFood(widget.food, _selectedFiles)
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
                onPressed: () {
                  _selectImage(null);
                },
                style: ElevatedButton.styleFrom(
                    primary: Color(0xffd17842),
                    textStyle: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Kanit',
                        fontWeight: FontWeight.bold)),
                child: Text('อัพโหลดรูปภาพ')),
          ),
        ],
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
                          widget.food.catefoodId =
                              data[index].categoryFoodId as int;
                          _selectedCategory = data[index].typeFood.toString();
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

  Widget _ShowOldImage() {
    return widget.food.imageFood!.isEmpty
        ? Text('ไม่มีรูปภาพ',
            style: TextStyle(fontSize: 20, color: Colors.white))
        : Container(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, childAspectRatio: 1),
              shrinkWrap: true,
              itemCount: widget.food.imageFood!.length,
              itemBuilder: (context, index) {
                return _Image(widget.food.imageFood![index]);
              },
            ),
          );
  }

  Widget _Image(ImageFood img) => Container(
        margin: EdgeInsets.all(10),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                  height: 65,
                  child: GestureDetector(
                    onTap: () =>
                        _selectImage(img).then((value) => setState(() {})),
                    child: Image.network(
                      '${API.BASE_URL}${img.path}',
                      fit: BoxFit.cover,
                      width: 100,
                      height: 90,
                    ),
                  )),
              IconButton(
                icon: Icon(Icons.delete, color: Colors.white),
                onPressed: () {},
              ),
            ],
          ),
        ),
      );

  Widget _ShowImage(List<XFile> images) {
    return images.isEmpty
        ? Container()
        : Container(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, childAspectRatio: 1),
              shrinkWrap: true,
              itemCount: images.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.all(10),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.file(
                      File(images[index].path),
                      fit: BoxFit.cover,
                      width: 100,
                    ),
                  ),
                );
              },
            ),
          );
  }

  Future<ImageFood?> _selectImage(ImageFood? data) async {
    if (data == null) {
      final List<XFile>? imgs = await _picker.pickMultiImage();
      if (imgs != null) {
        setState(() {
          _selectedFiles.addAll(imgs);
          print(_selectedFiles);
        });
      }
    } else {
      File imageSource;
      await _picker.pickImage(source: ImageSource.gallery).then((value) => {
            setState(() {
              _imageFile = File(value!.path);
              FoodService().updateImage(data, _imageFile);
            }),
          });
    }
    return data;
  }

  _Alet(String value) async {
    if (value == API.statucode) {
      Navigator.pop(context);
      return AdvanceSnackBar(
        message: "แก้ไขข้อมูลสำเร็จ",
        mode: Mode.ADVANCE,
        duration: Duration(seconds: 5),
      ).show(context);
    }
  }
}
