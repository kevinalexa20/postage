import 'package:cek_ongkir/view/auth/login_or_register.dart';
import 'package:cek_ongkir/view/homepage/cekongkir_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../controller/cubit/ongkir/cek_ongkir_cubit.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        //jika ada user yang login
        if (snapshot.hasData) {
          return const CekOngkirPage();
        }
        //jika tidak ada user yang login
        else {
          return const LoginOrRegister();
        }
      },
    ));
  }

 
}
