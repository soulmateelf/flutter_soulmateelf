/*
 * @Date: 2023-04-21 15:39:31
 * @LastEditors: Wws wuwensheng@donganyun.com
 * @LastEditTime: 2023-04-21 16:13:08
 * @FilePath: \soulmate\lib\views\base\photoView\view.dart
 */
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_soulmateelf/widgets/library/projectLibrary.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';

import 'logic.dart';

/// Author trevor
/// Date 2/21/22 4:30 PM
/// Description 预览图片
class PreviewPhotoPage extends StatelessWidget {
  final logic = Get.put(PreviewPhotoLogic());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return basePage("${logic.index.value + 1}/${logic.images?.length ?? 0}",
          child: Center(
            child: PageView(
              controller: logic.pageController,
              children: logic.images!.map((item) {
                return _buildPageItem(item);
              }).toList(),
              onPageChanged: (nowIndex) {
                if (nowIndex != logic.index.value) {
                  logic.index.value = nowIndex;
                }
              },
            ),
          ));
    });
  }

  /// Author trevor
  /// Date 2/21/22 4:44 PM
  /// Description 单项图片Item
  /// param
  /// return
  /// UpdateUser trevor
  /// UpdateDate 2/21/22 4:44 PM
  /// UpdateRemark
  Widget _buildPageItem(item) {
    return PhotoView(
      backgroundDecoration: const BoxDecoration(color: Colors.white),
      errorBuilder: (context, object, stackTrace) => Center(
          child: Text(
        'error',
        style: TextStyle(fontSize: 14.sp, color: Colors.black),
      )),
      maxScale: PhotoViewComputedScale.covered * 1.4,
      // imageProvider: NetworkImage(item['path']));
      imageProvider: renderImageProvider(item),
    );
  }

  ImageProvider<Object>? renderImageProvider(dynamic item) {
    if (logic.type == "network") {
      return NetworkImage(item["path"]);
    } else if (logic.type == "file") {
      return FileImage(File(item['path']));
    } else if (logic.type == "memory") {
      return MemoryImage(item?["data"]);
    } else {
      return null;
    }
  }
}
