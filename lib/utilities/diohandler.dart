import 'dart:developer';

import 'package:dio/dio.dart';

class DioHandler {
  static final Dio dio = Dio();
  static String baseUrl = "https://gho.azurewebsites.net/sk/iin/";
  static Future<dynamic> readMedical({
    required dynamic body,
  }) async {
    Map<String, dynamic> headers = {
      "Content-Type": "application/JSON",//json
    };
    dio.options.headers.addAll(headers);

    try {
      log("Sending request to $baseUrl with body: $body");
      Response response = await DioHandler.dio
          .post(
            baseUrl,
            data: body,
          )
          .timeout(const Duration(seconds: 60));

      log("Response: ${response.data}");
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
