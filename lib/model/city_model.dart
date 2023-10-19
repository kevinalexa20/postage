// class CityModel {
//   String cityId;
//   String provinceId;
//   String province;
//   String type;
//   String cityName;
//   String postalCode;

//   CityModel({
//     required this.cityId,
//     required this.provinceId,
//     required this.province,
//     required this.type,
//     required this.cityName,
//     required this.postalCode,
//   });

//   factory CityModel.fromJson(Map<String, dynamic> json) => CityModel(
//         cityId: json["city_id"],
//         provinceId: json["province_id"],
//         province: json["province"],
//         type: json["type"],
//         cityName: json["city_name"],
//         postalCode: json["postal_code"],
//       );
// }

class CityModel {
  CityModel({
    this.id,
    this.provinceId,
    this.province,
    this.type,
    this.cityName,
    this.postalCode,
  });

  String? id;
  String? provinceId;
  String? province;
  String? type;
  String? cityName;
  String? postalCode;

  factory CityModel.fromJson(Map<String, dynamic> json) => CityModel(
        id: json["city_id"],
        provinceId: json["province_id"],
        province: json["province"],
        type: json["type"],
        cityName: json["city_name"],
        postalCode: json["postal_code"],
      );

  Map<String, dynamic> toJson() => {
        "city_id": id,
        "province_id": provinceId,
        "province": province,
        "type": type,
        "city_name": cityName,
        "postal_code": postalCode,
      };
}
