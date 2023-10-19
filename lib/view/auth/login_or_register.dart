import 'package:cek_ongkir/view/auth/login_page.dart';
import 'package:cek_ongkir/view/auth/register_page.dart';
import 'package:flutter/material.dart';

import '../../controller/cubit/ongkir/cek_ongkir_cubit.dart';

class LoginOrRegister extends StatefulWidget {
  const LoginOrRegister({super.key});

  @override
  State<LoginOrRegister> createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister> {
  //Login page dulu
  bool showLoginPage = true;

  //toggle antara login register
  void togglePages() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  void dispose() {
    CekOngkirCubit().close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return LoginPage(onTap: togglePages);
    } else {
      return RegisterPage(onTap: togglePages);
    }
  }
}
