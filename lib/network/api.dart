import 'package:dio/dio.dart';

class DioHelper {
  static Dio? dio;

  static init() {
    dio =Dio(
      BaseOptions(
        baseUrl: 'https://student.valuxapps.com/api/',
        receiveDataWhenStatusError: true,
        headers: {
          'Content-Type': 'application/json',
        },
      ),
    );
  }

  static Future<Response> postData({
    required String path,
    required Map<String, dynamic> data,
  }) async {
    return await dio!.post(
      path,
      data: data,
    );
  }
}
