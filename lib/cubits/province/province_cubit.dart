import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:aplikasi_rumah_sakit/models/province_model.dart';
import 'package:aplikasi_rumah_sakit/services/province_service.dart';

// Province State
abstract class ProvinceState {}

class ProvinceInitial extends ProvinceState {}

class ProvinceLoading extends ProvinceState {}

class ProvinceLoaded extends ProvinceState {
  final Province province;

  ProvinceLoaded(this.province);
}

class ProvinceError extends ProvinceState {
  final String message;

  ProvinceError(this.message);
}

// Province Cubit
class ProvinceCubit extends Cubit<ProvinceState> {
  final ProvinceService provinceService;

  ProvinceCubit(this.provinceService) : super(ProvinceInitial());

  void fetchProvinces() async {
    try {
      emit(ProvinceLoading());
      final province = await provinceService.fetchProvince();
      emit(ProvinceLoaded(province));
    } catch (e) {
      emit(ProvinceError(e.toString()));
    }
  }
}
