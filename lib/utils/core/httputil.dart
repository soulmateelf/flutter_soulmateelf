import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_soulmateelf/utils/plugin/plugin.dart';
import 'package:flutter_soulmateelf/utils/tool/utils.dart';
import 'package:flutter_soulmateelf/utils/core/application.dart';
import 'package:flutter_soulmateelf/config.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_soulmateelf/widgets/library/projectLibrary.dart';
import 'package:get/get.dart' hide Response;

class NetUtils {
  /// 可选参数 params headers successCallBack errorCallBack
  static Future diorequst(String url, String method,
      {Map<String, dynamic>? params,
      Map<String, dynamic>? headers,
      Map<String, dynamic>? extra,
      Function? successCallBack,
      Function? errorCallBack,
      int connectTimeout = 30000}) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      Map errorResponseData = {"message": '请检查您的网络连接!'};
      _error(errorResponseData['message'], errorResponseData, errorCallBack);
      return null;
    }
    Dio dio = Dio(BaseOptions(
      baseUrl: ProjectConfig.getInstance()?.baseConfig['BaseUrl'],
      connectTimeout: Duration(milliseconds: connectTimeout),
      receiveTimeout: const Duration(milliseconds: 30000),
    ));
    Response response;
    try {
      Map<String, dynamic>? localHeaders;

      ///有传自定义head或者没传head参数取默认值
      var head = Application.pres?.getString('headers') ?? "{}";
      localHeaders = headers ?? jsonDecode(head);

      localHeaders?["Authorization"] = "Bearer ${Application.token}";
      localHeaders?["userId"] = Application.userInfo?["userId"];
      ///拦截器
      dio.interceptors.add(InterceptorsWrapper(
        onRequest: (RequestOptions options, handler) async {
          // Do something before request is sent
          /// header在这里直接赋值会导致其他header属性的丢失
          /// 所以在request函数中处理比较好
          /// 图片类型，在这里特殊处理header
          if (extra != null && extra["uploadImage"] == true) {
            options.data = params!["formdata"];
          }
          return handler.next(options);
          //continue
        },
        onResponse: (Response response, handler) async {
          // Do something with response data
          //图片类型，在这里特殊处理response
          return handler.next(response); // continue
        },
      ));

      ///正式请求
      response = await dio.request(
        url,
        queryParameters: method == 'get' ? params : null,
        data: method == 'post' ? params : null,
        options: Options(
            method: method,
            headers: localHeaders,
            contentType: extra != null && extra['isUrlencoded'] == true
                ? Headers.formUrlEncodedContentType
                : "application/json; charset=utf-8"),
      );

      ///处理response
      return _dealWithResponse(response, successCallBack, errorCallBack);
    } on DioError catch (dioError) {
      String realUrl = dio.options.baseUrl + url;
      print('$realUrl接口错误,请求方式$method');
      print('请求参数${params.toString()}');
      print(dioError.response);
      return _dealDioError(
          dioError, url, successCallBack, errorCallBack, params);
    } catch (exception) {
      APPPlugin.logger.d(exception);
      Map errorResponseData = {"message": exception.toString()};
      _error(errorResponseData['message'], errorResponseData, errorCallBack);
    }
  }

  static _dealDioError(DioError dioError, String url, Function? successCallBack,
      Function? errorCallBack, params) {
    switch (dioError.type) {
      case DioErrorType.cancel:
        Map errorResponseData = {"message": "请求取消！"};
        _error(errorResponseData['message'], errorResponseData, errorCallBack);
        break;
      case DioErrorType.connectionTimeout:
        Map errorResponseData = {"message": "连接超时！"};
        _error(errorResponseData['message'], errorResponseData, errorCallBack);
        break;
      case DioErrorType.sendTimeout:
        Map errorResponseData = {"message": "请求超时！"};
        _error(errorResponseData['message'], errorResponseData, errorCallBack);
        break;
      case DioErrorType.receiveTimeout:
        Map errorResponseData = {"message": "响应超时！"};
        _error(errorResponseData['message'], errorResponseData, errorCallBack);
        break;
      case DioErrorType.badResponse:
        // 其他类型的http返回码，比如 500 403 400 等等
        // 4.0app约定的账号登录信息失效是http状态码403
        // ----内部自定义code  403 未登录或登录信息失效！
        // ----内部自定义code  1000 账号在别处登录！
        int? errCode = dioError.response?.statusCode;
        print("请求失败，错误代码【$errCode】！");
        if (errCode == 400) {
          print('请检查请求的url是否正确！');
        }
        var responsedata = dioError.response?.data;
        if (errCode == 403) {
          if (responsedata['code'] == 403) {
            _error(responsedata['message'], responsedata, errorCallBack);
            Application.clearStorage().then((val) {
              Get.offAllNamed('login');
            });
          } else if (responsedata['code'] == 1000) {
            _error(responsedata['message'], responsedata, errorCallBack);
            Application.clearStorage().then((val) {
              Get.offAllNamed('login');
            });
          } else {
            _error(responsedata['message'], responsedata, errorCallBack);
          }
        } else {
          Map errorResponseData;
          if (ProjectConfig.getInstance()?.isDebug == true) {
            errorResponseData = {"message": "请求失败！${responsedata?['message']}"};
          } else {
            errorResponseData = {"message": "请求失败！"};
          }
          _error(
              errorResponseData['message'], errorResponseData, errorCallBack);
        }
        break;
      default:
        // var responsedata = dioError.response.data;
        Map errorResponseData;
        if (ProjectConfig.getInstance()?.isDebug == true) {
          errorResponseData = {"message": "请求失败！$dioError"};
        } else {
          errorResponseData = {"message": "请求失败！"};
        }
        _error(errorResponseData['message'], errorResponseData, errorCallBack);
    }
  }

  static _dealWithResponse(response, successCallBack, errorCallBack) {
    ///httpCode 200
    ///--自定义code  200 操作成功！
    ///--自定义code  500 操作失败！系统繁忙！非法参数！
    ///--自定义code  400 未登录！权限不足！
    ///

    return Future(() {
      if (response.statusCode == 200) {
        //http成功
        var responsedata = response.data;
        if (responsedata == null || responsedata == "") {
          successCallBack(responsedata);
        }

        //服务端返回码
        if (responsedata['code'] == 200) {
          // try捕获successCallBack异常，导致response无法返回给futureBuilderContainer来判断页面显示问题
          try {
            successCallBack(responsedata);
          } catch (e) {
            return response;
          }
        } else {
          // kele
          // 2020-09-10
          // 这里是后段自定义的错误码，此时http的状态码是200，app只需要弹出message即可
          // _error(responsedata['message'], responsedata, errorCallBack);
        }
      } else {
        //http失败
        _error('', null, errorCallBack);
      }
      return response;
    });
  }

  static _error(
      String errorMessage, Map? responsedata, Function? errorCallBack) {
    if (errorCallBack != null) {
      errorCallBack(responsedata);
    } else {
      if (Utils.isEmpty(errorMessage)) {
        errorMessage = '操作异常，请稍后再试！';
      }
      exSnackBar(errorMessage, type: 'error');
    }
  }
}
