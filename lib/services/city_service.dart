import 'dart:convert'; // Add this import for jsonDecode
import 'package:aplikasi_rumah_sakit/models/City_model.dart';
import 'package:dio/dio.dart';

class CityService {
  Future<City> fetchCities(String provinceId) async {
    final dio = Dio();

    try {
      final response = await dio.get(
        "https://rs-bed-covid-api.vercel.app/api/get-cities",
        queryParameters: {
          'provinceid': provinceId,
        },
      );
      if (response.statusCode == 200) {
        final data =
            response.data is String ? jsonDecode(response.data) : response.data;
        if (data is Map<String, dynamic> && data.containsKey('cities')) {
          return City.fromJson(data);
        } else {
          throw Exception("Unexpected response format");
        }
      } else {
        throw Exception("Failed to load City data");
      }
    } catch (e) {
      print('Error: $e');
      throw Exception("Failed to load City data: $e");
    }
  }
}
