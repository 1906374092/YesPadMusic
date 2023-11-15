import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:yes_play_music/config/config.dart';
import 'package:yes_play_music/utils/database.dart';
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
    //cookie_manager /data/user/0/com.example.yes_play_music/app_flutter
    try {
      // final Directory appDocDir = await getApplicationDocumentsDirectory();
      // final String appDocPath = appDocDir.path;
      // final jar = PersistCookieJar(
      //   ignoreExpires: true,
      //   storage: FileStorage("$appDocPath/.cookies/"),
      // );
      _dio.interceptors.add(CookieManager(CookieJar(ignoreExpires: true)));
    } catch (e) {
      logger.e(e);
    }
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
    String? cookie = CookieBase.cookie;
    if (cookie != null && cookie != '') {
      if (options.method == 'GET') {
        options.queryParameters.addAll({'cookie': Uri.encodeFull(cookie)});
      } else if (options.method == 'POST') {
        options.extra.addAll({'cookie': cookie});
      }
    }
    // logger.i(options.uri);
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    if ((response.data is Map) &&
        (response.data as Map).containsKey('cookie') &&
        response.data['cookie'] != '') {
      await CookieBase.saveCookie(response.data['cookie']);
    }
    if (response.statusCode == 401 || response.statusCode == 403) {
      await CookieBase.removeCookie();
    }
    super.onResponse(response, handler);
  }

  @override
  Future onError(DioException err, ErrorInterceptorHandler handler) async {
    super.onError(err, handler);
    EasyLoading.showError(err.message ?? '未知错误');
  }
}
