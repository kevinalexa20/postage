import 'dart:io';

import 'package:cek_ongkir/controller/cubit/ongkir/cek_ongkir_cubit.dart';
import 'package:cek_ongkir/routes.dart';
import 'package:cek_ongkir/view/homepage/results_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:textfield_search/textfield_search.dart';
import 'package:cek_ongkir/data/extensions.dart' as appExt;

class CekOngkirPage extends StatefulWidget {
  const CekOngkirPage({super.key});

  @override
  State<CekOngkirPage> createState() => _CekOngkirPageState();
}

class _CekOngkirPageState extends State<CekOngkirPage> {
  final CekOngkirCubit _cekOngkirCubit = CekOngkirCubit()..fetchCity();

  @override
  void dispose() {
    _cekOngkirCubit.close();
    super.dispose();
  }

  void logout() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener(
          bloc: _cekOngkirCubit,
          listener: (context, state) {
            if (state is CekOngkirFetchCitySuccess) {
              debugPrint('Fetch City Success');
            }
            if (state is CekOngkirFetchCityFailed) {
              debugPrint('Fetch City Failed');
            }
            if (state is CekOngkirPostOngkirSuccess) {
              debugPrint('Fetch Ongkir Success');
              appExt
                  .pushScreen(context, ResultPage(data: state.ongkir))
                  .then((value) => _cekOngkirCubit.fetchCity());
              // Navigator.pushNamed(
              //         context, ResultPage(data: state.ongkir) as String)
              //     .then((value) => _cekOngkirCubit.fetchCity());
            }
          },
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: SvgPicture.asset(
            'images/postagepro.svg',
            width: 245,
            height: 44,
          ),
          backgroundColor: const Color(0xFFE3F0FE),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: logout,
              icon: const Icon(
                Icons.logout,
                color: Color(0xFF421D54),
              ),
            ),
          ],
        ),
        body: BlocBuilder<CekOngkirCubit, CekOngkirState>(
          builder: (context, state) {
            List<String> listCityText = [];
            if (state is CekOngkirFetchCitySuccess) {
              listCityText =
                  state.listCity.map((e) => e.cityName ?? "").toList();
            }
            return Padding(
              padding: const EdgeInsets.all(30.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Text(
                      'Asal Pengiriman',
                      style: GoogleFonts.notoSans(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF421D54),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    FieldDropdownWithLabel(
                      dataList: listCityText,
                      label: 'Pilih Kota/Kabupaten',
                      text: '',
                      myController: _cekOngkirCubit.asalController,
                    ),
                    const SizedBox(
                      height: 36,
                    ),
                    Text(
                      'Tujuan Pengiriman',
                      style: GoogleFonts.notoSans(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF421D54),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    FieldDropdownWithLabel(
                      dataList: listCityText,
                      label: 'Pilih Kota/Kabupaten',
                      text: '',
                      myController: _cekOngkirCubit.tujuanController,
                    ),
                    const SizedBox(
                      height: 36,
                    ),
                    CourierFieldWithLabel(
                      listCourier: _cekOngkirCubit.listCourier,
                      onChange: (newValue) {
                        _cekOngkirCubit.selectedCourier = newValue ?? "JNE";
                      },
                    ),
                    WeightFieldWithLabel(
                      myController: _cekOngkirCubit.weightController,
                    ),
                    SizedBox(
                      height: 36,
                    ),
                    // const Expanded(
                    //   child: SizedBox(),
                    // ),
                    BlocBuilder<CekOngkirCubit, CekOngkirState>(
                        builder: (context, state) {
                      if (state is CekOngkirFetchCitySuccess) {
                        return ElevatedButton(
                          onPressed: () {
                            _cekOngkirCubit.cekOngkir(
                              origin: int.parse(state.listCity
                                  .firstWhere((element) => _cekOngkirCubit
                                      .asalController.text
                                      .contains(element.cityName!))
                                  .id!),
                              destination: int.parse(state.listCity
                                  .firstWhere((element) => _cekOngkirCubit
                                      .tujuanController.text
                                      .contains(element.cityName!))
                                  .id!),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFC94A38),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            minimumSize: const Size(400, 50),
                          ),
                          child: Text(
                            "Cek Ongkir",
                            style: GoogleFonts.notoSans(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFFE3F0FE),
                            ),
                          ),
                        );
                      }
                      return const SizedBox();
                    })
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class FieldDropdownWithLabel extends StatelessWidget {
  const FieldDropdownWithLabel({
    Key? key,
    required this.dataList,
    required this.label,
    required this.text,
    required this.myController,
  }) : super(key: key);

  final List<String> dataList;
  final String label, text;
  final TextEditingController myController;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(text),
        TextFieldSearch(
          initialList: dataList,
          label: label,
          controller: myController,
        ),
      ],
    );
  }
}

class CourierFieldWithLabel extends StatelessWidget {
  const CourierFieldWithLabel({
    Key? key,
    required this.listCourier,
    required this.onChange,
  }) : super(key: key);

  final List<String> listCourier;
  final Function(String?) onChange;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text("Pilih Kurir: "),
        const SizedBox(
          width: 12,
        ),
        DropdownButton<String>(
          value: listCourier[0],
          icon: const Icon(Icons.arrow_downward),
          elevation: 16,
          style: const TextStyle(color: Colors.deepPurple),
          underline: Container(
            height: 2,
            color: Colors.deepPurpleAccent,
          ),
          onChanged: (String? newValue) {
            onChange(newValue);
          },
          items: listCourier.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ],
    );
  }
}

class WeightFieldWithLabel extends StatelessWidget {
  const WeightFieldWithLabel({
    Key? key,
    required this.myController,
  }) : super(key: key);

  final TextEditingController myController;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text("Berat: "),
        const SizedBox(
          width: 12,
        ),
        Flexible(
          child: TextField(
            controller: myController,
            keyboardType: TextInputType.number,
            style: const TextStyle(color: Colors.deepPurple),
            onChanged: (String? newValue) {
              print(newValue);
            },
          ),
        ),
        const Text("gram"),
      ],
    );
  }
}
