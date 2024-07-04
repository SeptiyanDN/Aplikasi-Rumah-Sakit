import 'package:aplikasi_rumah_sakit/cubits/city/city_state.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:aplikasi_rumah_sakit/models/city_model.dart';
import 'package:aplikasi_rumah_sakit/services/city_service.dart';

class CityCubit extends Cubit<CityState> {
  final CityService cityService;

  CityCubit(this.cityService) : super(CityInitial());

  void fetchCities(String provinceId) async {
    try {
      emit(CityLoading());
      final cities = await cityService.fetchCities(provinceId);
      emit(CityLoaded(cities));
    } catch (e) {
      emit(CityError(e.toString()));
    }
  }
}
