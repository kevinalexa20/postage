import 'package:cek_ongkir/controller/cubit/ongkir/cek_ongkir_cubit.dart';
import 'package:cek_ongkir/routes.dart';
import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CekOngkirCubit()..fetchCity(),
        ),
      ],
      child: ScreenUtilInit(
        // child: MaterialApp.router(
        //   title: 'Flutter Demo',
        //   theme: ThemeData(
        //     colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        //     useMaterial3: true,
        //   ),
        //   routerConfig: appRouter,
        // ),
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, child) => MaterialApp.router(
          builder: (context, child) {
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
              child: child!,
            );
          },
          title: 'Postage Pro',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          debugShowCheckedModeBanner: false,
          routerConfig: appRouter,
        ),
      ),
    );
  }
}
