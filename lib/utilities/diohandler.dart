import 'dart:developer';

import 'package:dio/dio.dart';

class DioHandler {
  static final Dio dio = Dio();
  static const String baseUrl =
      "https://rereadmedical.azurewebsites.net/sk/iin/";

  static Future<dynamic> readMedical({
    required dynamic body,
  }) async {
    Map<String, dynamic> headers = {
      "content-type": "application/json",
    };
    dio.options.headers.addAll(headers);
    try {
      Response response;

      response = await DioHandler.dio
          .post(
            baseUrl,
            data: body,
          )
          .timeout(const Duration(seconds: 60));
      print(response.data);
      return response.data;
    } on DioException catch (e) {
      log("DioError: ${e.response?.data ?? e.message}");
      return {"error": "DioError: ${e.message}"};
    } catch (e) {
      log("Error: $e");
      return {"error": "Unknown error: $e"};
    }
  }
}
