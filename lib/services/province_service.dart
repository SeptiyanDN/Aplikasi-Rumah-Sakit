import 'dart:convert'; // Add this import for jsonDecode
import 'package:aplikasi_rumah_sakit/models/province_model.dart';
import 'package:dio/dio.dart';

class ProvinceService {
  Future<Province> fetchProvince() async {
    final dio = Dio();

    try {
      final response = await dio
          .get("https://rs-bed-covid-api.vercel.app/api/get-provinces");

      if (response.statusCode == 200) {
        final data =
            response.data is String ? jsonDecode(response.data) : response.data;
        if (data is Map<String, dynamic> && data.containsKey('provinces')) {
          return Province.fromJson(data);
        } else {
          throw Exception("Unexpected response format");
        }
      } else {
        throw Exception("Failed to load province data");
      }
    } catch (e) {
      print('Error: $e');
      throw Exception("Failed to load province data: $e");
    }
  }
}
