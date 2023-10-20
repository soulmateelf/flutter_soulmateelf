import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:soulmate/utils/plugin/plugin.dart';
import 'package:soulmate/utils/tool/utils.dart';
import 'package:soulmate/utils/core/application.dart';
import 'package:soulmate/config.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:soulmate/widgets/library/projectLibrary.dart';
import 'package:get/get.dart' hide Response;

class HttpUtils {
  /// dio实体初始化
  static Dio dio = Dio(BaseOptions(
    baseUrl: ProjectConfig.getInstance()?.baseConfig['BaseUrl'],
    connectTimeout: const Duration(milliseconds: 10000),
    receiveTimeout: const Duration(milliseconds: 30000),
  ));

  /// 请求方法
  static Future diorequst(String url,
      {String method = "get",
      dynamic? query,
      dynamic? params,
      Map<String, dynamic>? headers,
      Map<String, dynamic>? extra,
      int connectTimeout = 10000}) async {
    /// 判断网络状态
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      String errMessage = "please check you network!";
      Loading.toast(errMessage, toastPosition: EasyLoadingToastPosition.top);
      return _error(message: errMessage);
    }

    /// 覆盖参数
    HttpUtils.dio.options.connectTimeout =
        Duration(milliseconds: connectTimeout);

    /// response
    Response response;

    try {
      /// 有传自定义head或者没传head参数取默认值
      Map<String, dynamic>? localHeaders;
      localHeaders = headers ?? {};
      localHeaders["Authorization"] = "Bearer ${Application.token}";
      localHeaders["userId"] = Application.userInfo?["userId"];

      ///拦截器
      HttpUtils.dio.interceptors.add(InterceptorsWrapper(
        onRequest: (RequestOptions options, handler) async {
          // Do something before request is sent
          /// header在这里直接赋值会导致其他header属性的丢失
          /// 所以在request函数中处理比较好
          /// 图片类型，在这里特殊处理header
          if (extra != null && extra?["uploadImage"] == true) {
            options.data = params?["formdata"];
          }
          return handler.next(options);
        },
        onResponse: (Response response, handler) async {
          // Do something with response data
          //图片类型，在这里特殊处理response
          return handler.next(response); // continue
        },
        onError: (e, handler) {
          return handler.next(e);
        },
      ));

      /// 正式请求
      response = await dio.request(
        url,
        queryParameters: query,
        data: params,
        options: Options(
            method: method,
            headers: localHeaders,
            contentType: extra != null && extra['isUrlencoded'] == true
                ? Headers.multipartFormDataContentType
                : "application/json; charset=utf-8"),
      );

      ///处理response
      return _dealWithResponse(response);
    } on DioException catch (dioError) {
      String realUrl = dio.options.baseUrl + url;
      if (ProjectConfig.getInstance()?.isDebug == true) {
        APPPlugin.logger.d('$realUrl接口错误,请求方式$method');
        APPPlugin.logger.d('请求参数${query?.toString()}${params?.toString()}');
      }
      return _dealDioError(dioError, url);
    } catch (exception) {
      Map errorResponseData = {"message": exception.toString()};
      return _error(message: errorResponseData['message']);
    }
  }

  static _dealDioError(DioException dioError, String url) {
    String errMessage = "";
    switch (dioError.type) {
      case DioExceptionType.cancel:
        errMessage = "request cancel";
        break;
      case DioExceptionType.connectionTimeout:
        errMessage = "connectionTimeout!";
        break;
      case DioExceptionType.sendTimeout:
        errMessage = "sendTimeout!";
        break;
      case DioExceptionType.receiveTimeout:
        errMessage = "receiveTimeout!";
        break;
      case DioExceptionType.badResponse:
        // 其他类型的http返回码，比如 500 401 400 等等
        int? errCode = dioError.response?.statusCode;
        if (errCode == 401) {
          // 无效的登录信息
          if (Get.currentRoute != "/login") {
            errMessage = dioError.response?.data?['message'];
            Loading.toast(errMessage,
                toastPosition: EasyLoadingToastPosition.top);
            Application.clearStorage().then((val) {
              Get.offAllNamed('login');
            });
            return Future.error(errMessage);
          }
        } else {
          errMessage = "[$errCode]-something wrong!";
          if (ProjectConfig.getInstance()?.isDebug == true) {
            APPPlugin.logger.d("请求失败，错误代码【$errCode】！");
            APPPlugin.logger.d(dioError);
          }
        }
        break;
      default:
        // print(dioError.response);
        errMessage = "something wrong!";
        if (ProjectConfig.getInstance()?.isDebug == true) {
          APPPlugin.logger.d(dioError);
        }
    }
    return _error(message: errMessage);
  }

  static _dealWithResponse(response) {
    ///httpCode 200
    ///--自定义code  200 操作成功！
    ///--自定义code  500 操作失败！系统繁忙！非法参数！
    if (response.statusCode == 200) {
      //http成功
      var responsedata = response.data;
      //服务端返回码
      if (responsedata['code'] == 200) {
        return responsedata;
      } else {
        // 这里是后端自定义的错误码，此时http的状态码是200，app只需要弹出message即可
        return _error(message: responsedata['message']);
      }
    } else {
      //http失败
      return _error();
    }
  }

  /// 错误提示
  static _error({String message = 'something wrong！'}) {
    /// 本来是想在这里默认弹窗提示错误信息的，但是有些接口失败不想提示错误，比如升级接口，所以这里不做处理，错误处理统一交给页面的业务方法自己搞定
    /// Loading.toast(message, toastPosition: EasyLoadingToastPosition.top);
    return Future.error(message);
  }
}
