part of 'cek_ongkir_cubit.dart';

sealed class CekOngkirState extends Equatable {
  const CekOngkirState();

  @override
  List<Object> get props => [];
}

final class CekOngkirInitial extends CekOngkirState {}

class CekOngkirFetchCityLoading extends CekOngkirState {}

class CekOngkirFetchCityFailed extends CekOngkirState {}

class CekOngkirFetchCitySuccess extends CekOngkirState {
  final List<CityModel> listCity;

  const CekOngkirFetchCitySuccess({required this.listCity});

  // @override
  // List<Object> get props => [listCity];
}

class CekOngkirPostOngkirLoading extends CekOngkirState {}

class CekOngkirPostOngkirSuccess extends CekOngkirState {
  final Ongkir ongkir;

  const CekOngkirPostOngkirSuccess({required this.ongkir});

  // @override
  // List<Object> get props => [ongkir];
}

class CekOngkirPostOngkirFailed extends CekOngkirState {}
