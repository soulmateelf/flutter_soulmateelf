/*
 * @Date: 2023-04-13 14:39:24
 * @LastEditors: Wws wuwensheng@donganyun.com
 * @LastEditTime: 2023-04-23 16:29:35
 * @FilePath: \soulmate\lib\views\main\sendFeedback\view.dart
 */
import 'dart:io';

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_soulmateelf/utils/core/application.dart';
import 'package:flutter_soulmateelf/utils/core/httputil.dart';
import 'package:flutter_soulmateelf/utils/plugin/plugin.dart';
import 'package:flutter_soulmateelf/views/main/sendFeedback/bloc.dart';
import 'package:flutter_soulmateelf/widgets/library/projectLibrary.dart';
import 'package:get/get.dart' hide FormData, MultipartFile;
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

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
  List<dynamic> _images = [];

  _submit(SendFeedbackFormBloc bloc) async {
    final blocs = bloc.state.fieldBlocs()?.values ?? [];
    final validates =
        await Future.wait(blocs.map((element) => element.validate()));
    final validated = validates.every((element) => element);

    if (!validated) return;
    APPPlugin.logger.d(_images);
    final files = await Future.wait(
        _images.map((e) => MultipartFile.fromFile(e["path"])));

    final formData = FormData.fromMap({
      "email": bloc.email.value,
      "content": bloc.feedback.value,
      "file": files
    });

    final result = await NetUtils.diorequst("/base/feedback", 'post',
        params: formData, extra: {'isUrlencoded': true});
    if (result.data?["code"] == 200) {
      exSnackBar(result.data?["message"], onClose: () {
        print("back");
        Get.back();
      });
    }
  }

  Future<void> getImage(GetImageActionType actionType) async {
    /// 如果选择的是相册
    if (actionType == GetImageActionType.photo) {
      await Permission.photos.status.then((status) async{
        print(status);
        print(PermissionStatus.permanentlyDenied == status);
        if(status == PermissionStatus.permanentlyDenied){
          print(222);
          openAppSettings();
        } else if (status != PermissionStatus.granted) {
          print(1111);
          var aa = await Permission.photos.request();
          print(aa);
          print(await Permission.photos.status);
        }
      });
      return;
      final files = await ImagePicker().pickMultiImage();
      files.forEach((file) {
        _images.add({"path": file.path});
      });
      setState(() {});
    } else if (actionType == GetImageActionType.shoot) {
      // 如果选择的拍摄
      final XFile? image =
          await ImagePicker().pickImage(source: ImageSource.camera);
      if (image != null) {
        final imagePath = image.path;
        setState(() {
          _images.add({"path": imagePath});
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
                              filled: true,
                              fillColor: Colors.white,
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
                              Padding(
                                padding: EdgeInsets.only(bottom: 8.w),
                                child: Text(
                                    "Upload relevant pictures or information"),
                              ),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: [
                                    InkWell(
                                      onTap: () async {
                                        final result =
                                            await showConfirmationDialog(
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
                                      },
                                      child: Container(
                                        width: 156.w,
                                        height: 156.w,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                width: 1.w,
                                                color: Color.fromRGBO(
                                                    153, 153, 153, 1)),
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
                                                style:
                                                    TextStyle(fontSize: 26.sp),
                                              ),
                                            ]),
                                      ),
                                    ),
                                    ...renderImages()
                                  ],
                                ),
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
                          margin: EdgeInsets.symmetric(horizontal: 24.w),
                          child: TextFieldBlocBuilder(
                            textFieldBloc: bloc.email,
                            decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                label: Text("Email for contact"),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 2.w, color: Colors.black))),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 24.w),
                          margin: EdgeInsets.only(top: 24.w),
                          width: double.infinity,
                          height: 94.w,
                          child: ElevatedButton(
                            child: Text(
                              "Send",
                              style: TextStyle(fontSize: 36.sp),
                            ),
                            onPressed: () {
                              _submit(bloc);
                            },
                          ),
                        )
                      ]),
                ),
              );
            },
          ),
        ));
  }

  void removeImages(int index) {
    setState(() {
      _images.removeAt(index);
    });
  }

  List<Widget> renderImages() {
    List<Widget> widgets = [];
    for (int i = 0; i < _images.length; i++) {
      widgets.add(
        InkWell(
            onTap: () {
              // removeImages(i);
              Get.toNamed('previewPhoto',
                  arguments: {"images": _images, "index": i, "type": "file"});
            },
            child: Container(
              width: 156.w,
              height: 156.w,
              margin: EdgeInsets.only(left: 8.w),
              child: Stack(
                children: [
                  Image.file(
                    File(_images[i as dynamic]?["path"]),
                    width: 156.w,
                    height: 156.w,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Text("error");
                    },
                  ),
                  Positioned(
                      top: 0,
                      right: 0,
                      child: InkWell(
                        onTap: () {
                          removeImages(i);
                        },
                        child: Icon(Icons.close),
                      ))
                ],
              ),
            )),
      );
    }
    return widgets;
  }
}
