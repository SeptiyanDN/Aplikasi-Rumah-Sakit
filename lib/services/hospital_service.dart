import 'dart:convert';

import 'package:aplikasi_rumah_sakit/models/hospital_model.dart';
import 'package:dio/dio.dart';
import 'package:aplikasi_rumah_sakit/models/province_model.dart';

class HospitalService {
  Future<Hospital> fetchHospital(String provinceId, String cityId) async {
    final dio = Dio();

    try {
      final response = await dio.get(
        "https://rs-bed-covid-api.vercel.app/api/get-hospitals",
        queryParameters: {
          'provinceid': provinceId,
          'cityid': cityId,
          'type': 1
        },
      );

      print('Response: ${response.data}');

      if (response.statusCode == 200) {
        final data =
            response.data is String ? jsonDecode(response.data) : response.data;
        if (data is Map<String, dynamic> && data.containsKey('hospitals')) {
          return Hospital.fromJson(data);
        } else {
          throw Exception("Unexpected response format");
        }
      } else {
        print('Error: ');

        throw Exception("Failed to load city data");
      }
    } catch (e) {
      print('Error: $e');
      throw Exception("Failed to load city data: $e");
    }
  }
}
