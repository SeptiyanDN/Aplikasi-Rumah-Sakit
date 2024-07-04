import 'package:aplikasi_rumah_sakit/models/City_model.dart';
import 'package:aplikasi_rumah_sakit/models/hospital_model.dart';

sealed class HospitalState {}

final class HospitalInitial extends HospitalState {}

final class HospitalLoading extends HospitalState {}

final class HospitalLoaded extends HospitalState {
  final Hospital hospital;

  HospitalLoaded(this.hospital);
}

final class HospitalError extends HospitalState {
  final String message;

  HospitalError(this.message);
}
