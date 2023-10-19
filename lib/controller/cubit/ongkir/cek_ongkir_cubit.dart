import 'package:bloc/bloc.dart';
import 'package:cek_ongkir/data/services/city_service.dart';
import 'package:cek_ongkir/data/services/ongkir_service.dart';
import 'package:cek_ongkir/model/ongkir_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../model/city_model.dart';

part 'cek_ongkir_state.dart';

class CekOngkirCubit extends Cubit<CekOngkirState> {
  CekOngkirCubit() : super(CekOngkirInitial());

  final List<String> listKotaKab = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5'
  ];

  final List<String> listCourier = [
    'JNE',
    'POS Indonesia',
    'TIKI',
  ];

  String selectedCourier = "JNE";

  final TextEditingController asalController = TextEditingController();

  final TextEditingController tujuanController = TextEditingController();

  final TextEditingController courierController = TextEditingController();
  final TextEditingController weightController = TextEditingController();

  final OngkirService _ongkirService = OngkirService();
  final CityService _cityService = CityService();

  Future<void> fetchCity() async {
    emit(CekOngkirFetchCityLoading());
    try {
      await Future.delayed(const Duration(seconds: 2));
      List<CityModel> listData = await _cityService.fetchCity();
      emit(CekOngkirFetchCitySuccess(listCity: listData));
    } catch (e) {
      emit(CekOngkirFetchCityFailed());
    }
  }

  Future<void> cekOngkir({
    required int origin,
    required int destination,
  }) async {
    emit(CekOngkirPostOngkirLoading());
    try {
      Ongkir ongkir = await _ongkirService.checkCost(
        origin: origin,
        destination: destination,
        weight: int.parse(weightController.text),
        courier: selectedCourier.toLowerCase(),
      );
      emit(CekOngkirPostOngkirSuccess(ongkir: ongkir));
    } catch (e) {
      emit(CekOngkirPostOngkirFailed());
      return;
    }
  }
}
