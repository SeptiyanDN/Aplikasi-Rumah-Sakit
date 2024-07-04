import 'package:aplikasi_rumah_sakit/models/province_model.dart';

sealed class ProvinceState {}

final class ProvinceInitial extends ProvinceState {}

final class ProvinceLoading extends ProvinceState {}

final class ProvinceLoaded extends ProvinceState {
  final Province province;

  ProvinceLoaded(this.province);
}

final class ProvinceError extends ProvinceState {
  final String message;

  ProvinceError(this.message);
}
