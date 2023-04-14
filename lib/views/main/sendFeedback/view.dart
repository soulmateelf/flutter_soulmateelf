/*
 * @Date: 2023-04-13 14:39:24
 * @LastEditors: Wws wuwensheng@donganyun.com
 * @LastEditTime: 2023-04-14 10:37:14
 * @FilePath: \soulmate\lib\views\main\sendFeedback\view.dart
 */
import 'dart:ffi';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_soulmateelf/views/main/sendFeedback/bloc.dart';
import 'package:flutter_soulmateelf/widgets/library/projectLibrary.dart';
import 'package:image_picker/image_picker.dart';

class SendFeedbackPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SendFeedbackPage();
  }
}

class _SendFeedbackPage extends State<SendFeedbackPage> {
  var _fileData;

  Future<void> getImage() async {
    final XFile? file =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    final Uint8List? data = await file?.readAsBytes();
    setState(() {
      _fileData = data;
    });
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
                  child: Column(children: [
                    TextFieldBlocBuilder(
                      textFieldBloc: bloc.feedback,
                      maxLines: 14,
                      decoration: InputDecoration(
                          hintText: "Have feedback? We'd love to hear it.",
                          border: OutlineInputBorder(
                              borderSide:
                                  BorderSide(width: 2.w, color: Colors.black))),
                    ),
                    TextButton(
                        onPressed: () {
                          getImage();
                        },
                        child: Text("123")),
                    if (_fileData is Uint8List)
                      Container(
                        color: Colors.red,
                        child: Image.memory(
                          _fileData,
                          width: 100,
                          height: 100,
                        ),
                      ),
                  ]),
                ),
              );
            },
          ),
        ));
  }
}
