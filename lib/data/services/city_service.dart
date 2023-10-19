import 'package:dio/dio.dart';

import '../../model/city_model.dart';
import '../../model/province_model.dart';
import '../config/dio_client.dart';

class CityService {
  Future<List<ProvinceModel>> fetchProvince() async {
    // ...
    try {
      final response = await dioClient.get('/province');
      final data = response.data['rajaongkir']['results'] as List;
      return data.map((e) => ProvinceModel.fromJson(e)).toList();
    } on DioException catch (e) {
      throw Exception(e.message);
    }
  }

  // Future<List<CityModel>> fetchCity(String provinceId) async {
  //   // ...
  //   try {
  //     final response = await dioClient.get('/city?province=$provinceId');
  //     final data = response.data['rajaongkir']['results'] as List;
  //     return data.map((e) => CityModel.fromJson(e)).toList();
  //   } on DioException catch (e) {
  //     throw Exception(e.message);
  //   }
  // }

  Future<List<CityModel>> fetchCity() async {
    final response = await dioClient.get('/city');

    List<CityModel> data = List<CityModel>.from(response.data['rajaongkir']
            ['results']
        .map((json) => CityModel.fromJson(json)));

        return data;
  }
}
