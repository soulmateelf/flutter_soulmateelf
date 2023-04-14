/*
 * @Date: 2023-04-13 14:39:24
 * @LastEditors: Wws wuwensheng@donganyun.com
 * @LastEditTime: 2023-04-14 17:29:40
 * @FilePath: \soulmate\lib\views\main\sendFeedback\view.dart
 */
import 'dart:ffi';
import 'dart:io';
import 'dart:typed_data';

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_soulmateelf/views/main/sendFeedback/bloc.dart';
import 'package:flutter_soulmateelf/widgets/library/projectLibrary.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';

class SendFeedbackPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SendFeedbackPage();
  }
}

/// 选择获取图片的方式
enum GetImageActionType {
  /// 拍摄
  shoot,

  /// 相册
  photo,
}

class _SendFeedbackPage extends State<SendFeedbackPage> {
  var _fileDataList = [];

  Future<void> getImage(GetImageActionType actionType) async {
    /// 如果选择的是相册
    if (actionType == GetImageActionType.photo) {
      final files = await ImagePicker().pickMultiImage();
      final datas = await Future.wait<Uint8List>(files.map((e) {
        return e.readAsBytes();
      }));
      setState(() {
        _fileDataList = datas;
      });
    } else if (actionType == GetImageActionType.shoot) {
      // 如果选择的拍摄
      final XFile? image =
          await ImagePicker().pickImage(source: ImageSource.camera);
      if (image != null) {
        final imageData = await image.readAsBytes();
        setState(() {
          _fileDataList = [imageData];
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return basePage("send feedback",
        child: BlocProvider(
          create: (context) => SendFeedbackFormBloc(),
          child: Builder(
            builder: (context) {
              final bloc = context.read<SendFeedbackFormBloc>();
              return SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 24.w),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFieldBlocBuilder(
                          textFieldBloc: bloc.feedback,
                          maxLines: 16,
                          decoration: InputDecoration(
                              hintText: "Have feedback? We'd love to hear it.",
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 2.w, color: Colors.black))),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 24.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Upload relevant pictures or information"),
                              InkWell(
                                onTap: () async {
                                  final result = await showConfirmationDialog(
                                      context: context,
                                      title: "select",
                                      actions: [
                                        const AlertDialogAction(
                                          key: GetImageActionType.shoot,
                                          label: 'shoot',
                                        ),
                                        const AlertDialogAction(
                                          key: GetImageActionType.photo,
                                          label: 'photo',
                                        ),
                                      ]);
                                  if (result != null) {
                                    getImage(result);
                                  }
                                  print(result);
                                },
                                child: Container(
                                  width: 156.w,
                                  height: 156.w,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 1.w,
                                          color:
                                              Color.fromRGBO(153, 153, 153, 1)),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(4.w))),
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.add,
                                          size: 50.sp,
                                        ),
                                        Text(
                                          "upload",
                                          style: TextStyle(fontSize: 26.sp),
                                        ),
                                      ]),
                                ),
                              ),
                              Row(
                                children: renderImages(),
                              ),
                            ],
                          ),
                        ),
                        CheckboxFieldBlocBuilder(
                            booleanFieldBloc: bloc.allowConcact,
                            body: Text(
                              "We may email you for more information or updates.",
                              style: TextStyle(fontSize: 22.sp),
                            )),
                        Container(
                          height: 120.w,
                          padding: EdgeInsets.symmetric(horizontal: 24.w),
                          child: TextFieldBlocBuilder(
                            textFieldBloc: bloc.email,
                            decoration: InputDecoration(
                                label: Text("Email for contact"),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 2.w, color: Colors.black))),
                          ),
                        ),
                      ]),
                ),
              );
            },
          ),
        ));
  }

  void removeImages(int index) {
    setState(() {
      _fileDataList.removeAt(index);
    });
  }

  List<Widget> renderImages() {
    List<Widget> widgets = [];
    for (int i = 0; i < _fileDataList.length; i++) {
      widgets.add(
        InkWell(
            onTap: () {
              removeImages(i);
            },
            child: Container(
              child: Image.memory(
                _fileDataList[i as dynamic],
                width: 156.w,
                height: 156.w,
                fit: BoxFit.cover,
              ),
            )),
      );
    }
    return widgets;
  }
}
