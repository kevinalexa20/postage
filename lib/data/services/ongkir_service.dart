import "package:cek_ongkir/model/ongkir_model.dart";
import "package:dio/dio.dart";

import "../../model/city_model.dart";
import "../../model/province_model.dart";
import "../config/dio_client.dart";

class OngkirService {
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

  Future<List<CityModel>> fetchCity(String provinceId) async {
    // ...
    try {
      final response = await dioClient.get('/city?province=$provinceId');
      final data = response.data['rajaongkir']['results'] as List;
      return data.map((e) => CityModel.fromJson(e)).toList();
    } on DioException catch (e) {
      throw Exception(e.message);
    }
  }

  // Future<CostResponseModel> checkCost(
  //   CostRequestModel data,

  // ) async {
  //   try {
  //     final response = await dioClient.post('/cost');

  //     CostResponseModel data =
  //         CostResponseModel.fromJson(response.data["rajaongkir"]["results"][0]);
  //     return data;

  //     // final data = response.data['rajaongkir']['results'][0]['costs'][0];
  //     // return CostResponseModel.fromJson(data);
  //   } on DioException catch (e) {
  //     throw Exception(e.message);
  //   }
  // }

  Future<Ongkir> checkCost({
    required int origin,
    required int destination,
    required int weight,
    required String courier,
  }) async {
    try {
      final response = await dioClient.post('/cost', data: {
        "origin": origin.toString(),
        "destination": destination.toString(),
        "weight": weight.toString(),
        "courier": courier,
      });

      Ongkir data = Ongkir.fromJson(response.data["rajaongkir"]["results"][0]);
      return data;

      // final data = response.data['rajaongkir']['results'][0]['costs'][0];
      // return CostResponseModel.fromJson(data);
    } on DioException catch (e) {
      throw Exception(e.message);
    }
  }
}
