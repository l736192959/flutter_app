import 'package:dio/dio.dart';

class Net {
  static Dio _dio;
  static Options _options;
  final _baseUrl = "";

  Net._internal() {
    _options = Options()
      ..baseUrl = _baseUrl
      ..connectTimeout = 30 * 1000;
    _dio = Dio()..options = _options;
  }

  static Net _instance;

  static Net get instance => _getInstance();

  factory Net() => _getInstance();

  static Net _getInstance() {
    if (_instance == null) {
      _instance = Net._internal();
    }
    return _instance;
  }

  Future<Response<T>> get<T>(String path,
      {Map<String, dynamic> params, Map<String, dynamic> header}) {
    Options options;
    if (header != null) {
      options = _options;
      options.headers.addAll(header);
    }
    return options == null
        ? _dio.get(path)
        : _dio.get(path, data: params, options: options);
  }
}
