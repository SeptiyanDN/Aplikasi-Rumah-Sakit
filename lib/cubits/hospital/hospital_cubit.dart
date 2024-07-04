import 'package:aplikasi_rumah_sakit/cubits/hospital/hospital_state.dart';
import 'package:aplikasi_rumah_sakit/models/hospital_model.dart'; // Adjust import based on your project structure
import 'package:aplikasi_rumah_sakit/services/hospital_service.dart';
import 'package:bloc/bloc.dart';

class HospitalCubit extends Cubit<HospitalState> {
  final HospitalService hospitalService;

  HospitalCubit(this.hospitalService) : super(HospitalInitial());

  void fetchHospitals(String provinceId, String cityId) async {
    try {
      emit(HospitalLoading());
      final hospitals = await hospitalService.fetchHospital(provinceId, cityId);
      print('Hospitals: $hospitals');
      emit(HospitalLoaded(hospitals));
    } catch (e) {
      emit(HospitalError(e.toString()));
    }
  }
}
