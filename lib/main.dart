import 'package:aplikasi_rumah_sakit/cubits/city/city_cubit.dart';
import 'package:aplikasi_rumah_sakit/cubits/hospital/hospital_cubit.dart';
import 'package:aplikasi_rumah_sakit/cubits/province/province_cubit.dart';
import 'package:aplikasi_rumah_sakit/screens/home.dart';
import 'package:aplikasi_rumah_sakit/services/city_service.dart';
import 'package:aplikasi_rumah_sakit/services/hospital_service.dart';
import 'package:aplikasi_rumah_sakit/services/province_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ProvinceCubit(ProvinceService()),
        ),
        BlocProvider(
          create: (context) => CityCubit(CityService()),
        ),
        BlocProvider(
          create: (context) => HospitalCubit(HospitalService()),
        ),
      ],
      child: MaterialApp(
        title: 'Rumah Sakit App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HospitalScreen(),
      ),
    );
  }
}
