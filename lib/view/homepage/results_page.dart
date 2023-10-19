import 'package:flutter/material.dart';
import 'package:cek_ongkir/controller/cubit/ongkir/cek_ongkir_cubit.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../model/ongkir_model.dart';

class ResultPage extends StatelessWidget {
  final Ongkir data;

  const ResultPage({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final ongkirData = context.state.ongkir;
    return Scaffold(
      appBar: AppBar(
        title: Text("Total Ongkir",
            style: GoogleFonts.notoSans(
              fontWeight: FontWeight.bold,
              fontSize: 28,
              color: const Color(0xFF421D54),
            )),
        backgroundColor: const Color(0xFFE3F0FE),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(children: [
          LabelWithValue(
            label: "Kurir",
            value: data.code ?? "",
          ),
          LabelWithValue(
            label: "Nama Kurir",
            value: data.name ?? "",
          ),
          SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: data.costs?.length ?? 0,
              itemBuilder: ((context, index) {
                return Column(
                  children: [
                    LabelWithValue(
                      label: "Service",
                      value: data.costs?[index].service ?? "",
                    ),
                    LabelWithValue(
                      label: "Description",
                      value: data.costs?[index].description ?? "",
                    ),
                    LabelWithValue(
                      label: "Cost",
                      value: data.costs?[index].cost?[0].value.toString() ?? "",
                    ),
                    LabelWithValue(
                      label: "Estimasi",
                      value: data.costs?[index].cost?[0].etd.toString() ?? "",
                    ),
                  ],
                );
              }),
            ),
          )
        ]),
      ),
    );
  }
}

class LabelWithValue extends StatelessWidget {
  const LabelWithValue({
    Key? key,
    required this.label,
    required this.value,
  }) : super(key: key);

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(label,
            style: GoogleFonts.notoSans(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: const Color(0xFF421D54),
            )),
        Text(': '),
        Text(value,
            style: GoogleFonts.notoSans(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            )),
      ],
    );
  }
}
