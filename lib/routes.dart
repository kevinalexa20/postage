import 'package:cek_ongkir/view/auth/auth.dart';
import 'package:cek_ongkir/view/auth/login_or_register.dart';
import 'package:cek_ongkir/view/auth/login_page.dart';
import 'package:cek_ongkir/view/auth/register_page.dart';
import 'package:cek_ongkir/view/homepage/results_page.dart';
import 'package:cek_ongkir/view/splashscreen/intro_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'model/ongkir_model.dart';
import 'view/homepage/cekongkir_page.dart';
import 'package:cek_ongkir/controller/cubit/ongkir/cek_ongkir_cubit.dart';

final appRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => IntroPage(),
    ),
    GoRoute(
      path: '/auth',
      builder: (context, state) => AuthPage(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => CekOngkirPage(),
    ),
    GoRoute(
      path: '/result',
      builder: (BuildContext context, GoRouterState state) =>
          ResultPage(data: Ongkir()),
    ),
  ],
);
