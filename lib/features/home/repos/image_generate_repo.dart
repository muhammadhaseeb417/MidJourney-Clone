import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';

class ImageGenerateRepo {
  static Future<Uint8List?> imageGeneration(String prompt) async {
    String url = 'https://api.vyro.ai/v1/imagine/api/generations';

    Map<String, dynamic> headers = {'Authorization': 'Bearer Your-Api-Key'};

    // Converting payload to FormData
    FormData formData = FormData.fromMap({
      'prompt': prompt,
      'style_id': '31',
    });

    Dio dio = Dio();
    dio.options = BaseOptions(
      headers: headers,
      responseType: ResponseType.bytes,
    );

    print("Payload: $formData");
    print("Headers: $headers");

    try {
      final response = await dio.post(url, data: formData);

      if (response.statusCode == 200) {
        Uint8List uint8list = Uint8List.fromList(response.data);
        return uint8list;
      } else {
        print("Error: ${response.statusCode} - ${response.data}");
        return null;
      }
    } on DioError catch (e) {
      print("DioError: ${e.response?.statusCode} - ${e.response?.data}");
      return null;
    }
  }
}
