import 'dart:io';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:path_provider/path_provider.dart';
import 'package:yes_play_music/config/config.dart';
import 'package:yes_play_music/utils/global.dart';

class HttpManager {
  late Dio _dio;
  factory HttpManager() => _getInstance();
  // instance的getter方法 - 通过HttpManager.instance获取对象
  static HttpManager get instance => _getInstance();
  // 静态变量_instance，存储唯一对象
  static HttpManager? _instance;
  // 获取唯一对象
  static HttpManager _getInstance() {
    _instance ??= HttpManager._internal();
    return _instance!;
  }

  //初始化...
  HttpManager._internal() {
    _configDio();
    //初始化其他操作...
  }

  _configDio() async {
    _dio = Dio();
    _dio.options.baseUrl = Config.DEBUG
        ? "https://music.liyp.cc/api"
        : "https://music.liyp.cc/api";
    _dio.options.connectTimeout = const Duration(seconds: 60);
    _dio.options.receiveTimeout = const Duration(seconds: 60);
    _dio.interceptors.add(CustomInterceptors());
    //cookie_manager
    try {
      final Directory appDocDir = await getApplicationDocumentsDirectory();
      final String appDocPath = appDocDir.path;
      final jar = PersistCookieJar(
        ignoreExpires: true,
        storage: FileStorage("$appDocPath/.cookies/"),
      );
      _dio.interceptors.add(CookieManager(jar));
    } catch (e) {}
  }

  dynamic post(String path, {required Map<String, dynamic> params}) async {
    try {
      Response<Map> response = await _dio.post(
        path,
        data: params,
      );
      return response.data;
    } on DioException catch (e) {
      if (e.response != null) {
        logger.d(e.error.toString());
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        logger.d(e.requestOptions);
        logger.d(e.message);
      }
    }
  }

  dynamic get(String path) async {
    try {
      Response<Map> response = await _dio.get(path);
      return response.data;
    } on DioException catch (e) {
      logger.d(e.error.toString());
    }
  }
}

class CustomInterceptors extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    logger.d(options.path);
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // logger.d(response.data);
    super.onResponse(response, handler);
  }

  @override
  Future onError(DioException err, ErrorInterceptorHandler handler) async {
    super.onError(err, handler);
  }
}
