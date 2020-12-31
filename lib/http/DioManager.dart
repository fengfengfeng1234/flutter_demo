import 'package:dio/dio.dart';

import '../data/apis/Apis.dart';
import 'error/ErrorEntity.dart';
import 'info/BaseEntity.dart';
import 'info/BaseListEntity.dart';
import 'info/BasePagerEntity.dart';

enum Method { GET, POST, DELETE, PUT }

const MethodValues = {
  Method.GET: "get",
  Method.POST: "post",
  Method.DELETE: "delete",
  Method.PUT: "put",
};

class DioManager {
  static final DioManager _shared = DioManager._internal();

  factory DioManager() => _shared;
  static Dio dio;

  DioManager._internal() {
    if (dio == null) {
      BaseOptions options = BaseOptions(
        contentType: Headers.jsonContentType,
        responseType: ResponseType.json,
        receiveDataWhenStatusError: false,
        connectTimeout: 30000,
        receiveTimeout: 3000,
      );
      dio = Dio(options);
    }
  }

  void setConfig(String baseUrl) {
    dio.options.baseUrl = baseUrl;
  }

  // 请求，返回参数为 T
  // method：请求方法，NWMethod.POST等
  // path：请求地址
  // params：请求参数
  // success：请求成功回调
  // error：请求失败回调
  Future request<T>(Method method, String path,
      {Map params, Function(T) success, Function(ErrorEntity) error}) async {
    try {
      Response response = await dio.request(path,
          queryParameters: params,
          options: Options(method: MethodValues[method]));
      if (response != null) {
        BaseEntity entity = BaseEntity<T>.fromJson(response.data);
        if (entity.errorCode == 0) {
          success(entity.data);
        } else {
          error(ErrorEntity(code: entity.errorCode, message: entity.errorMsg));
        }
      } else {
        error(ErrorEntity(code: -1, message: "未知错误"));
      }
    } on DioError catch (e) {
      error(createErrorEntity(e));
    }
  }

  // 请求，返回参数为 List
  // method：请求方法，NWMethod.POST等
  // path：请求地址
  // params：请求参数
  // success：请求成功回调
  // error：请求失败回调
  Future requestList<T>(Method method, String path,
      {Map params,
      Function(BaseListEntity<T>) success,
      Function(ErrorEntity) error}) async {
    try {
      Response response = await dio.request(path,
          queryParameters: params,
          options: Options(method: MethodValues[method]));
      if (response != null) {
        BaseListEntity entity = BaseListEntity<T>.fromJson(response.data);
        if (entity.errorCode == 0) {
          success(entity);
        } else {
          error(ErrorEntity(code: entity.errorCode, message: entity.errorMsg));
        }
      } else {
        error(ErrorEntity(code: -1, message: "未知错误"));
      }
    } on DioError catch (e) {
      error(createErrorEntity(e));
    }
  }

  // 请求，返回参数为 List
  // method：请求方法，NWMethod.POST等
  // path：请求地址
  // params：请求参数
  // success：请求成功回调
  // error：请求失败回调
  Future requestPager<T>(Method method, String path,
      {Map params,
      Function(BasePagerEntity<T>) success,
      Function(ErrorEntity) error}) async {
    try {
      Response response = await dio.request(path,
          queryParameters: params,
          options: Options(method: MethodValues[method]));
      if (response != null) {
        PagerEntity entity = PagerEntity<T>.fromJson(response.data);
        if (entity.errorCode == 0) {
          success(entity.data);
        } else {
          error(ErrorEntity(code: entity.errorCode, message: entity.errorMsg));
        }
      } else {
        error(ErrorEntity(code: -1, message: "未知错误"));
      }
    } on DioError catch (e) {
      error(createErrorEntity(e));
    }

  }

  // 错误信息
  ErrorEntity createErrorEntity(DioError error) {
    switch (error.type) {
      case DioErrorType.CANCEL:
        {
          return ErrorEntity(code: -1, message: "请求取消");
        }
        break;
      case DioErrorType.CONNECT_TIMEOUT:
        {
          return ErrorEntity(code: -1, message: "连接超时");
        }
        break;
      case DioErrorType.SEND_TIMEOUT:
        {
          return ErrorEntity(code: -1, message: "请求超时");
        }
        break;
      case DioErrorType.RECEIVE_TIMEOUT:
        {
          return ErrorEntity(code: -1, message: "响应超时");
        }
        break;
      case DioErrorType.RESPONSE:
        {
          try {
            int errCode = error.response.statusCode;
            String errMsg = error.response.statusMessage;
            return ErrorEntity(code: errCode, message: errMsg);
          } on Exception catch (_) {
            return ErrorEntity(code: -1, message: "未知错误");
          }
        }
        break;
      default:
        {
          return ErrorEntity(code: -1, message: error.message);
        }
    }
  }
}
